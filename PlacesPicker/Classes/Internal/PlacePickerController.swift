//
//  PlacePickerController.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 05/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

public class PlacePickerController: UIViewController, PlacesDataSourceDelegate {
    // Public
    public unowned var delegate: PlacesPickerDelegate?
    
    public override func loadView() {
        self.view = PlacePickerView(frame: CGRect.zero)
        pickerView.mapView.delegate = self
        config.pickerRenderer.configureMapView(mapView: pickerView.mapView)
        
        pickerView.tableView.delegate = self
        pickerView.tableView.dataSource = placesDataSource
        config.listRenderer.registerCells(tableView: pickerView.tableView)
        config.pickerRenderer.configureTableView(mapView: pickerView.tableView)
        placesDataSource.tableView = pickerView.tableView
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setInitialCoordinateIfNeeded()
    }
    
    private func setInitialCoordinateIfNeeded() {
        if let initialCoordinate = self.config.initialCoordinate {
            let position = GMSCameraPosition(latitude: initialCoordinate.latitude, longitude: initialCoordinate.longitude, zoom: config.initialZoom)
            pickerView.mapView.animate(to: position)
        }
    }
    
    // Internal
    
    private var placesDataSource: PlacesDataSource!
    private var config: PlacePickerConfig!
    
    private var pickerView: PlacePickerView {
        return view as! PlacePickerView
    }
    
    private func setupNavigationBar() {
        let searchButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(showPlacesSearch))
        config.pickerRenderer.configureSearchButton(barButtonItem: searchButton)
        self.navigationItem.rightBarButtonItem = searchButton
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelSelection))
        config.pickerRenderer.configureCancelButton(barButtonItem: cancelButton)
        self.navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc
    private func cancelSelection() {
        self.delegate?.placePickerControllerDidCancel(controller: self)
    }
    
    private lazy var marker: GMSMarker = {
       return GMSMarker(position: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
    }()
    
    @objc
    private func showPlacesSearch() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = placesDataSource
        autocompleteController.placeFields = config.placeFields
        autocompleteController.autocompleteFilter = config.placesFilter
        
        present(autocompleteController, animated: true, completion: nil)
    }
    
    fileprivate func selectPlaceAt(coordinate: CLLocationCoordinate2D) {
        focusOn(coordinate: coordinate)
        
        let bounds = pickerView.mapView.cameraTargetBounds ??
            GMSCoordinateBounds(coordinate: pickerView.mapView.projection.visibleRegion().nearLeft,
                                coordinate: pickerView.mapView.projection.visibleRegion().farRight)
        
        placesDataSource.fetchPlacesFor(coordinate: coordinate, bounds:bounds)
    }
    
    private func focusOn(coordinate: CLLocationCoordinate2D) {
        marker.position = coordinate
        marker.map = pickerView.mapView
        let zoom = pickerView.mapView.camera.zoom >= 10 ? pickerView.mapView.camera.zoom : 10
        let position = GMSCameraPosition(target: coordinate, zoom: zoom)
        pickerView.mapView.animate(to: position)
    }
    
    internal func placePickerDidSelectPlace(place: AddressResult) {
        delegate?.placePickerController(controller: self, didSelectPlace: place)
    }
    
    internal func autoCompleteControllerDidProvide(place: GMSPlace) {
        focusOn(coordinate: place.coordinate)
    }
}

extension PlacePickerController: GMSMapViewDelegate {
    public func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        selectPlaceAt(coordinate: coordinate)
    }
    
    public func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        marker.position = location
        marker.map = pickerView.mapView
        pickerView.mapView.animate(toLocation: location)
        placesDataSource.fetchPlaceDetails(placeId: placeID)
    }
  
}

extension PlacePickerController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        placesDataSource.didSelectListItemAt(index: indexPath.row)
    }
}

public extension PlacePickerController {
    static func controler(config: PlacePickerConfig) -> PlacePickerController {
        let controller = PlacePickerController()
        controller.config = config
        controller.placesDataSource = PlacesDataSource(renderer: config.listRenderer, geocoder: GMSGeocoder())
        controller.placesDataSource.delegate = controller
        return controller
    }
}
