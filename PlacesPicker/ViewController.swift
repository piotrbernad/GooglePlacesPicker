//
//  ViewController.swift
//  PlacesPicker
//
//  Created by Piotr Bernad on 03/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import UIKit
import PlacePicker
import GooglePlaces

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        PlacePicker.configure(googleMapsAPIKey: "", placesAPIKey: "")
    }

    @IBAction func showPlacePicker(_ sender: Any) {
        let controller = PlacePicker.placePickerController()
        controller.delegate = self
        let navigationController = UINavigationController(rootViewController: controller)
        self.show(navigationController, sender: nil)
    }
    
}

extension ViewController: PlacesPickerDelegate {
    func placePickerControllerDidCancel(controller: PlacePickerController) {
        controller.navigationController?.dismiss(animated: true, completion: nil)
    }
    
    func placePickerController(controller: PlacePickerController, didSelectPlace place: AddressResult) {
        controller.navigationController?.dismiss(animated: true, completion: nil)
    }
}

