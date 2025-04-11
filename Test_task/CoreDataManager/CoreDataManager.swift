//
//  CoreDataMAnager.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//

import Foundation
import CoreData
import UIKit

final class CoreDataManager{
    
    //MARK: Properties
    static let shared = CoreDataManager()
    private let persistantContainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext{
        return persistantContainer.viewContext
    }
    
    
    //MARK: Initializer
    private init() {
        self.persistantContainer = NSPersistentContainer(name: "Characters")
        self.persistantContainer.loadPersistentStores { _, error in
            if let error = error{
                print("Failed Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    //MARK: Methods
    func saveContext(){
        if viewContext.hasChanges{
            do{
                try viewContext.save()
            } catch {
                viewContext.rollback()
                print("Failed Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func fetchCharacters() -> [CharacterEntity]{
        let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        guard let characters = try? viewContext.fetch(fetchRequest) else {
            print("Error occured while CoreData fetching")
            return []
        }
        return characters
    }
    
    func fetchCharacters() -> [Character]{
        let fetchRequest: NSFetchRequest<CharacterEntity> = CharacterEntity.fetchRequest()
        guard let charactersCD = try? viewContext.fetch(fetchRequest) else {
            print("Error occured while CoreData fetching")
            return []
        }
        var characters: [Character] = []
        for characterCD in charactersCD {
            if let character = convertToCharacter(characterCD){
                characters.append(character)
            }
        }
        return characters
    }
    
    func addCharacter(character: Character){
        let characterCD = CharacterEntity(context: viewContext)
        guard let image = character.image.jpegData(compressionQuality: .greatestFiniteMagnitude) else {return}
        characterCD.name = character.name
        characterCD.status = character.status
        characterCD.type = character.type
        characterCD.gender = character.gender
        characterCD.originName = character.originName
        characterCD.locationName = character.locationName
        characterCD.image = image
        characterCD.dateCreated = character.dateCreated
        
        saveContext()
    }
    
    private func deleteCharacter(character: CharacterEntity){
        viewContext.delete(character)
        saveContext()
    }
    
    
    func deleteAllCharacters(){
        let characters:[CharacterEntity] = fetchCharacters()
        for character in characters{
            deleteCharacter(character: character)
        }
    }
    
    
    private func convertToCharacter(_ character: CharacterEntity) -> Character?{
        guard let image = UIImage(data: character.image) else {return nil}
        return Character(name: character.name, status: character.status, type: character.type, gender: character.gender, originName: character.originName, locationName: character.locationName, image: image, dateCreated: character.dateCreated)
    }
}
