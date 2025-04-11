//
//  NetworkManager.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 09.04.2025.
//

import Foundation
import UIKit

final class APIManager{
    
    //MARK: Initializer
    init() {}
    
    //MARK: Methods
    func getCharactersListAPI() async throws -> Array<Character> {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character")
        else {
            print("Invalid URL")
            return []
        }
        let (data, _) = try await URLSession.shared.data(from: url)
        var res:Array<Character> = []
        guard let jsonData = try? JSONSerialization.jsonObject(with: data) as? [String:Any],
              let charactersInfo = jsonData["results"] as? [[String:Any]]
        else{
            print("Invalid data")
            return []
        }
        for info in charactersInfo{
            guard let name = info["name"] as? String,
                  let status = info["status"] as? String,
                  let type = info["type"] as? String,
                  let gender = info["gender"] as? String,
                  let origin = info["origin"] as? [String:String],
                  let location = info["location"] as? [String:String],
                  let originName = origin["name"],
                  let locationName = location["name"],
                  let date = info["created"] as? String,
                  let dateCreated = self.convertDate(strdate: date)
            else {
                print("Invalid types")
                return []
            }
            
            guard let imageURLstring = info["image"] as? String,
                  let imageURL = URL(string: imageURLstring),
                  let image = self.getImage(url: imageURL)
            else {
                print("Invalid image URL")
                return []
            }
            
            let character = Character(name: name, status: status, type: type, gender: gender, originName: originName, locationName: locationName, image: image, dateCreated: dateCreated)
            
            res.append(character)
        }
        return res
    }
    
    private func getImage(url: URL) -> UIImage?{
        let data = try? Data(contentsOf: url)
        if let data = data{
            let image = UIImage(data: data)
            return image
        }
        return nil
    }
    
    private func convertDate(strdate: String)-> Date?{
        let formatter = ISO8601DateFormatter()
        formatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
        return formatter.date(from: strdate)
    }
    
    func downloadList(){
        CoreDataManager.shared.deleteAllCharacters()
        Task{
            do{
                let characters = try await self.getCharactersListAPI()
                DispatchQueue.main.async {
                    for character in characters {
                        CoreDataManager.shared.addCharacter(character: character)
                    }
                }
            } catch{
                print(error.localizedDescription)
            }
        }
    }
}
