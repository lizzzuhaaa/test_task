//
//  CharacterListPresenter.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit

protocol CharacterListPresentationLogic
{
    func presentCharacterList(response: CharacterList.FetchCharacter.Response)
}

class CharacterListPresenter: CharacterListPresentationLogic
{
    weak var viewController: CharacterListDisplayLogic?
    
    // MARK: Send list to VC
    
    func presentCharacterList(response: CharacterList.FetchCharacter.Response)
    {
        let characters = response.characters
        let viewModel = CharacterList.FetchCharacter.ViewModel(characters: characters)
        viewController?.displayCharacterList(viewModel: viewModel)
    }
}
