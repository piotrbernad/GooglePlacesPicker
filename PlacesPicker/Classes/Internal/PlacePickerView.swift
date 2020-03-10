//
//  PlacePickerView.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 05/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import UIKit
import GoogleMaps

class PlacePickerView: UIView {
    var tableView: UITableView!
    var mapView: GMSMapView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        setupMapView()
        setupTableView()
        addConstraints()
    }
    
    func addConstraints() {
        NSLayoutConstraint.activate(
            [tableView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4),
             tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
             tableView.leftAnchor.constraint(equalTo: leftAnchor),
             tableView.rightAnchor.constraint(equalTo: rightAnchor)])
        
        NSLayoutConstraint.activate(
            [mapView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
             mapView.topAnchor.constraint(equalTo: topAnchor),
             mapView.leftAnchor.constraint(equalTo: leftAnchor),
             mapView.rightAnchor.constraint(equalTo: rightAnchor)])
    }
    
    private func setupTableView() {
        self.tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(tableView)
    }
    
    private func setupMapView() {
        self.mapView = GMSMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(mapView)
    }
    
}
