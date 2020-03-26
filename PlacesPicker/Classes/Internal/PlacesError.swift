//
//  PlacesError.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation

public enum PlacesError: LocalizedError {
    case couldNotFindPlacesForAddress
    
    public var localizedDescription: String {
        return NSLocalizedString("Sorry, we could not find any place at this addresss. Please use search or try different location.", comment: "")
    }
    
    public var failureReason: String? {
        return localizedDescription
    }
    
    public var errorDescription: String? {
        return localizedDescription
    }
}
