//
//  PlacesListRenderer.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import UIKit

public protocol PlacesListRenderer {
    func registerCells(tableView: UITableView)
    func cellForRowAt(indexPath: IndexPath, tableView: UITableView, object: PlacesListObjectType) -> UITableViewCell
}
