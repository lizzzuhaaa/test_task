//
//  CharacterListInteractor.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit

protocol CharacterListBusinessLogic
{
    func fetchCharacter(request: CharacterList.FetchCharacter.Request)
}

protocol CharacterListDataStore
{
    func getCharacter(at index: Int) -> Character?
}

class CharacterListInteractor: CharacterListBusinessLogic, CharacterListDataStore
{
    var presenter: CharacterListPresentationLogic?
    var worker: CharacterListWorker?
    private var characters: [Character] = []
    
    // MARK: Fetch Character
    
    func fetchCharacter(request:  CharacterList.FetchCharacter.Request)
    {
        worker = CharacterListWorker()
        Task{
            do{
                guard let characters = await worker?.fetchCharacters() else {return}
                self.characters = characters
                let response = CharacterList.FetchCharacter.Response(characters: characters)
                presenter?.presentCharacterList(response: response)
            }
        }
    }
    
    func getCharacter(at index: Int) -> Character? {
        guard characters.indices.contains(index) else { return nil }
        return characters[index]
    }
}
