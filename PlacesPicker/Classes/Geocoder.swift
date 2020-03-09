//
//  Geocoder.swift
//  PlacesPicker
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation
import GoogleMaps

public enum GeocoderError: Error {
    case couldNotBuildRequest
}

public class Geocoder {
    private let baseUrl: URL = URL(string: "https://maps.googleapis.com/maps/api/geocode/json")!
    private let apiKey: String
    
    public init() {
        guard let googleMapsKey = PlacePicker.googleMapsKey else {
            fatalError("Missing Google Maps Key. Please call PlacePicker.configure() before using Picker.")
        }
        self.apiKey = googleMapsKey
    }
    
    public func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, completionHandler: @escaping (ReverseGeocodeResponse?, Error?) -> ()) {
        
        var components = URLComponents(url: baseUrl, resolvingAgainstBaseURL: true)
        components?.queryItems = [URLQueryItem(name: "latlng", value: "\(coordinate.latitude),\(coordinate.longitude)"),
                                  URLQueryItem(name: "key", value: apiKey)]
        
        guard let url = components?.url else {
            completionHandler(nil, GeocoderError.couldNotBuildRequest)
            return
        }
        
        perfromGeocodeRequest(url: url, completion: completionHandler)
        
    }
    
    private func perfromGeocodeRequest(url: URL, completion: @escaping (ReverseGeocodeResponse?, Error?) -> ()) {
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                let decodedResponse = try jsonDecoder.decode(ReverseGeocodeResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(decodedResponse, nil)
                }
            } catch let error {
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
        }
        
        task.resume()
    }
}
