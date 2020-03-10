//
//  DefaultListRenderer.swift
//  PlacePicker-iOS
//
//  Created by Piotr Bernad on 07/07/2019.
//  Copyright © 2019 Piotr Bernad. All rights reserved.
//

import UIKit

public class DefaultPlacesListRenderer: PlacesListRenderer {
    public init() {}
    
    public func registerCells(tableView: UITableView) {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    public func cellForRowAt(indexPath: IndexPath, tableView: UITableView, object: PlacesListObjectType) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        
        switch object {
        case .address(let address):
            cell.textLabel?.text = address.formattedAddress
            cell.accessoryType = .disclosureIndicator
            return cell
        case .error(let error):
            cell.textLabel?.text = error.localizedDescription
            cell.accessoryType = .none
            return cell
        case .loading:
            cell.textLabel?.text = NSLocalizedString("Loading", comment: "")
            cell.accessoryType = .none
            return cell
        case .nothingSelected:
            cell.textLabel?.text = NSLocalizedString("Please select location on the map or use search.", comment: "")
            cell.accessoryType = .none
            return cell
        }
    }
    
    
}
