//
//  CharacterListWorker.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import UIKit
import Combine
class CharacterListWorker
{
    private var cancellables = Set<AnyCancellable>()
    func fetchCharacters() async -> [Character]
    {
        let apiManager = APIManager()
        return await withCheckedContinuation { continuation in
            NetworkManager.shared.$isConnected
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .prefix(1)
                .sink { isConnected in
                    if isConnected {
                        Task{
                            do{
                                let characters = try await apiManager.getCharactersListAPI()
                                apiManager.downloadList()
                                continuation.resume(returning: characters)
                                
                            } catch{
                                print(error.localizedDescription)
                                continuation.resume(returning: [])
                            }
                        }
                    }
                    else {
                        let characters: [Character] = CoreDataManager.shared.fetchCharacters()
                        NetworkManager.shared.stopMonitoring()
                        continuation.resume(returning: characters)
                    }
                }
                .store(in: &cancellables)
        }
    }
}
