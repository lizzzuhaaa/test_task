//
//  CharacterListRouter.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import Foundation
import UIKit

import UIKit

@objc protocol CharacterListRoutingLogic
{
    func routeToCharacterDetails()
}

protocol CharacterListDataPassing
{
    var dataStore: CharacterListDataStore? { get }
}

class CharacterListRouter: NSObject, CharacterListRoutingLogic, CharacterListDataPassing
{
    weak var viewController: CharacterListViewController?
    var dataStore: CharacterListDataStore?
    
    // MARK: Routing
    
    func routeToCharacterDetails() {
        let destinationVC = CharacterDetailsViewController()
        if let selectedIndexPath = viewController?.tableView.indexPathForSelectedRow,
           let character = dataStore?.getCharacter(at: selectedIndexPath.row) {
            destinationVC.character = character
        }
        viewController?.navigationController?.pushViewController(destinationVC, animated: true)
    }
}
