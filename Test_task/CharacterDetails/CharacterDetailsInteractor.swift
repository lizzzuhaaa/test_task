//
//  CharacterDetailsInteractor.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit

protocol CharacterDetailsBusinessLogic
{
    func fetchCharacterDetails(request: CharacterDetails.FetchCharacterDetails.Request)
}

class CharacterDetailsInteractor: CharacterDetailsBusinessLogic
{
    var presenter: CharacterDetailsPresentationLogic?
    
    // MARK: Fetch details
    func fetchCharacterDetails(request: CharacterDetails.FetchCharacterDetails.Request)
    {
        let response = CharacterDetails.FetchCharacterDetails.Response(character: request.character)
        presenter?.presentCharacterDetails(response: response)
    }
}
