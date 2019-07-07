//
//  PlacesListObjectType.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation
import GoogleMaps
import GooglePlaces

public enum PlacesListObjectType {
    case loading
    case nothingSelected
    case place(place: GMSPlace)
    case error(error: Error)
    case address(address: ReverseGeocodeResult)
}
