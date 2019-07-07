//
//  ReverseGeocodeResponse.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation

public struct ReverseGeocodeResponse: Codable {
    public let results: [ReverseGeocodeResult]
}

public struct ReverseGeocodeResult: Codable {
    public let formattedAddress: String
    public let placeId: String
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case placeId = "place_id"
    }
}
