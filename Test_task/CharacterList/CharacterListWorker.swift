//
//  CharacterListWorker.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit

class CharacterListWorker
{
    func fetchCharacters() async -> [Character]
    {
        let apiManager = APIManager()
        if NetworkManager.shared.isConnected{
            do{
                return try await apiManager.getCharactersListAPI()
                
            } catch{
                print(error.localizedDescription)
                return []
            }
        }
        else{
            let characters: [Character] = CoreDataManager.shared.fetchCharacters()
            NetworkManager.shared.stopMonitoring()
            return characters
        }
    }
}
