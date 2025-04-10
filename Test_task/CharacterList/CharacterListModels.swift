//
//  CharacterListModels.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import Foundation
import UIKit

enum CharacterList
{
    // MARK: Use cases
    enum FetchCharacter
    {
        struct Request {}
        struct Response { let characters: [Character]}
        struct ViewModel { let characters: [Character]}
    }
}



