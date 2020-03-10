//
//  ListState.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation
import GooglePlaces
import GoogleMaps

public enum ListState {
    case nothingSelected
    case loading
    case singlePlace(place: GMSPlace)
    case error(error: Error)
    case adresses(objects: [ReverseGeocodeResult])
}
