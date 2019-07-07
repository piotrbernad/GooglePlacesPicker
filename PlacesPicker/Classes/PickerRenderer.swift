//
//  PickerRenderer.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import Foundation
import GoogleMaps

public protocol PickerRenderer {
    func configureCancelButton(barButtonItem: UIBarButtonItem)
    func configureSearchButton(barButtonItem: UIBarButtonItem)
    func configureMapView(mapView: GMSMapView)
    func configureTableView(mapView: UITableView)
}

public class DefaultPickerRenderer: PickerRenderer {
    public init() { }
    
    public func configureCancelButton(barButtonItem: UIBarButtonItem) {
    }
    
    public func configureSearchButton(barButtonItem: UIBarButtonItem) {
    }
    
    public func configureMapView(mapView: GMSMapView) {
    }
    
    public func configureTableView(mapView: UITableView) {
    }
}
