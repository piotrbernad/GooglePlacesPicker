//
//  PlacePicker_iOSTests.swift
//  PlacePicker-iOSTests
//
//  Created by Piotr Bernad on 04/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import XCTest
@testable import PlacePicker

class PlacePicker_iOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

extension CLLocationCoordinate2D {
    static var Prague: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 50.08804, longitude: 14.42076)
    }
    
    static var Bratislava: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: 48.14816, longitude: 17.10674)
    }
}

}
