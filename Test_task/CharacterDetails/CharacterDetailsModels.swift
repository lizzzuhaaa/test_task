//
//  CharacterDetailsModels.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit

enum CharacterDetails{
    // MARK: Use cases
    
    enum FetchCharacterDetails
    {
        struct Request {let character: Character}
        struct Response {let character: Character}
        struct ViewModel {
            let name: String
            let status: String
            let type: String
            let gender: String
            let originName: String
            let locationName: String
            let image: UIImage
            let dateCreated: String
        }
    }
}

