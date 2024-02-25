//
//  JokeEntity+CoreDataProperties.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//
//

import Foundation
import CoreData


extension JokeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<JokeEntity> {
        return NSFetchRequest<JokeEntity>(entityName: "JokeEntity")
    }

    @NSManaged public var id: String?
    @NSManaged public var value: String?
    
    func toJokeModel() -> JokeModel {
        return JokeModel(id: id, value: value)
    }
}

extension JokeEntity : Identifiable {

}
