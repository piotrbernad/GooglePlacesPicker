//
//  PlacePicker_iOSTests.swift
//  PlacePicker-iOSTests
//
//  Created by Piotr Bernad on 04/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import CoreLocation
import GooglePlaces
import GoogleMaps
import XCTest
@testable import PlacePicker

class PlacePicker_iOSTests: XCTestCase {
    
    let renderer_mock = PlacesListRenderer_Mock()
    let geocoder_mock = GMSGeocoder_Mock()
    let placesClient_mock = GMSPlacesClient_Mock()
    var dataSource_mock: PlacesDataSource!
    var tableView: UITableView!
    
    override func setUp() {
        self.dataSource_mock = PlacesDataSource(renderer: renderer_mock, geocoder: geocoder_mock, placesClient: placesClient_mock)
        self.tableView = UITableView()
        dataSource_mock.tableView = tableView
    }
    
    func testMockedfetchPlacesFor() {
        dataSource_mock.fetchPlacesFor(coordinate: .Prague, bounds: nil)
        let rows = dataSource_mock.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 2)
    }
    
    func testDidSelectListItemAtPlace() {
        let delegate = PlacesDataSourceDelegate_Mock()
        dataSource_mock.delegate = delegate
        dataSource_mock.fetchPlaceDetails(placeId: String.PragueNationalMuseum)
        let rows = dataSource_mock.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 1)
        if rows == 1 {
            dataSource_mock.didSelectListItemAt(index: 0)
            XCTAssertEqual(delegate.flag, true)
        }
    }
    
    func testDidSelectListItemAtAddress() {
        let delegate = PlacesDataSourceDelegate_Mock()
        dataSource_mock.delegate = delegate
        dataSource_mock.fetchPlacesFor(coordinate: .Prague, bounds: nil)
        let rows = dataSource_mock.tableView(tableView, numberOfRowsInSection: 0)
        XCTAssertEqual(rows, 2)
        if rows == 2 {
            dataSource_mock.didSelectListItemAt(index: 0)
            XCTAssertEqual(delegate.flag, true)
        }
    }
    
    func testDidSelectListItemAtWhenEmpty() {
        let delegate = PlacesDataSourceDelegate_Mock()
        dataSource_mock.delegate = delegate
        dataSource_mock.fetchPlacesFor(coordinate: .Bratislava, bounds: nil)
        dataSource_mock.didSelectListItemAt(index: 0)
        XCTAssertEqual(delegate.flag, false)
    }
    
    func testDidSelectListItemAtError() {
        let delegate = PlacesDataSourceDelegate_Mock()
        dataSource_mock.delegate = delegate
        dataSource_mock.fetchPlacesFor(coordinate: CLLocationCoordinate2D(), bounds: nil)
        dataSource_mock.didSelectListItemAt(index: 0)
        XCTAssertEqual(delegate.flag, false)
    }
    
    // MARK: tests using real geocoder
    func testFetchPlacesFor() {
        let location = CLLocationCoordinate2D(latitude: 50.0706333725773, longitude: 50.0706333725773)
        let dataSource = PlacesDataSource(renderer: renderer_mock, geocoder: GMSGeocoder())
        dataSource.tableView = tableView
        dataSource.fetchPlacesFor(coordinate: location, bounds: nil)
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            let rows = dataSource.tableView(dataSource.tableView!, numberOfRowsInSection: 0)
            XCTAssert(rows > 0)
            if rows > 0 {
                let cell = dataSource.tableView(dataSource.tableView!, cellForRowAt: IndexPath(row: 0, section: 0)) as! TestCell
                XCTAssert(cell.state.isAddress)
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }

    func testfetchPlaceDetails() {
        let dataSource = PlacesDataSource(renderer: renderer_mock, geocoder: GMSGeocoder())
        dataSource.tableView = tableView
        dataSource.fetchPlaceDetails(placeId: .PragueNationalMuseum)
        let exp = expectation(description: "Test after 5 seconds")
        let result = XCTWaiter.wait(for: [exp], timeout: 5.0)
        if result == XCTWaiter.Result.timedOut {
            let rows = dataSource.tableView(dataSource.tableView!, numberOfRowsInSection: 0)
            XCTAssert(rows > 0)
            if rows > 0 {
                let cell = dataSource.tableView(dataSource.tableView!, cellForRowAt: IndexPath(row: 0, section: 0)) as! TestCell
                XCTAssert(cell.state.isAddress)
            }
        } else {
            XCTFail("Delay interrupted")
        }
    }
}

class TestError: Error {}

struct GMSGeocoder_Mock: GeocoderProtocol {
    func reverseGeocodeCoordinate(_ coordinate: CLLocationCoordinate2D, completionHandler: @escaping (ReverseGeocodeResponse?, Error?) -> ()) {
        switch coordinate {
        case .Prague:
            let response = ReverseGeocodeResponse(results: [ReverseGeocodeResult(formattedAddress: "Some address", placeId: "Some id"), ReverseGeocodeResult(formattedAddress: "Some other address", placeId: "Some id")])
            return completionHandler(response, nil)
        case .Bratislava:
            return completionHandler(ReverseGeocodeResponse(results: []), nil)
        default:
            return completionHandler(nil, TestError())
        }
    }
}

struct PlacesListRenderer_Mock: PlacesListRenderer {
    func registerCells(tableView: UITableView) {
        tableView.register(TestCell.self, forCellReuseIdentifier: "test")
    }
    
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView, object: PlacesListObjectType) -> UITableViewCell {
        let cell = TestCell()
        cell.state = object
        return cell
    }
}

class PlacesDataSourceDelegate_Mock: PlacesDataSourceDelegate {
    var flag: Bool = false
    
    func placePickerDidSelectPlace(place: GMSPlace) {
        flag = true
    }
    
    func autoCompleteControllerDidProvide(place: GMSPlace) {}
}

class GMSPlacesClient_Mock: GMSPlacesClient {
    override func lookUpPlaceID(_ placeID: String, callback: @escaping GMSPlaceResultCallback) {
        let place = GMSPlace_Mock(name: "some", placeID: String.PragueNationalMuseum, coordinate: CLLocationCoordinate2D())
        switch placeID {
        case String.PragueNationalMuseum:
            return callback(place, nil)
        default:
            return
        }
    }
}

class GMSPlace_Mock: GMSPlace {

    let _name: String
    let _placeID: String
    let _coordinate: CLLocationCoordinate2D

    init(name: String, placeID: String, coordinate: CLLocationCoordinate2D) {
        self._name = name
        self._placeID = placeID
        self._coordinate = coordinate
    }

    override var name: String {
        return _name
    }

    override var placeID: String {
        return _placeID
    }

    override var coordinate: CLLocationCoordinate2D {
        return _coordinate
    }

}

extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}

extension CLLocationCoordinate2D {
    static var Prague: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 50.08804, longitude: 14.42076)
    }
    
    static var Bratislava: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 48.14816, longitude: 17.10674)
    }
}

extension PlacesListObjectType {

    var isAddress: Bool {
        if case .address = self {
            return true
        }
        return false
    }

}

class TestCell: UITableViewCell {
    var state: PlacesListObjectType!
}

extension String {
    static var PragueNationalMuseum: String { return "ChIJua9Ogo2UC0cRpkk9dANajkI" }
}
