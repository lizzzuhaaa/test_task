//
//  CharacterEntity+CoreDataProperties.swift
//  Test_task
//
//  Created by лізушка лізушкіна on 10.04.2025.
//
//

import Foundation
import CoreData


extension CharacterEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CharacterEntity> {
        return NSFetchRequest<CharacterEntity>(entityName: "CharacterEntity")
    }

    @NSManaged public var dateCreated: Date?
    @NSManaged public var gender: String?
    @NSManaged public var image: Data?
    @NSManaged public var locationName: String?
    @NSManaged public var name: String?
    @NSManaged public var originName: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?

}

extension CharacterEntity : Identifiable {

}
