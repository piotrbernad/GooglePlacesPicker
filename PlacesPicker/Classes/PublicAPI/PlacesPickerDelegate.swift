//
//  PlacesPickerDelegate.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation
import GooglePlaces

public protocol PlacesPickerDelegate: class {
    func placePickerController(controller: PlacePickerController, didSelectPlace place: AddressResult)
    func placePickerControllerDidCancel(controller: PlacePickerController)
}
