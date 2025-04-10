//
//  CharacterDetailsPresenter.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit

protocol CharacterDetailsPresentationLogic
{
    func presentCharacterDetails(response: CharacterDetails.FetchCharacterDetails.Response)
}

class CharacterDetailsPresenter: CharacterDetailsPresentationLogic
{
    weak var viewController: CharacterDetailsDisplayLogic?
    
    // MARK: Perform for VC
    
    func presentCharacterDetails(response: CharacterDetails.FetchCharacterDetails.Response)
    {
        let character = response.character
        
        let name = character.name
        let status = "Status: " + character.status
        let type = "Tyoe: " + character.type
        let gender = "Gender: " + character.gender
        let originName = "Origin: " + character.originName
        let locationName = "Location: " + character.locationName
        let image = character.image
        let dateCreated = "Created: " + convertDate(character.dateCreated)
        let viewModel = CharacterDetails.FetchCharacterDetails.ViewModel(name: name, status: status, type: type, gender: gender, originName: originName, locationName: locationName, image: image, dateCreated: dateCreated)
        viewController?.displayCharacterDetails(viewModel: viewModel)
    }
    
    private func convertDate(_ date: Date) -> String{
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
