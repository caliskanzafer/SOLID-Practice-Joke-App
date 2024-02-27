//
//  CoreDataService.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 25.02.2024.
//



import UIKit

final class CoreDataManager {
    
    
}

extension CoreDataManager: RepositoryManagerProtocol {
    func getJokes() -> [JokeModelProtocol] {
        do {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return []}
            
            let items = try context.fetch(JokeEntity.fetchRequest())
            
            var jokeList: [JokeModel] = []
            
            items.forEach { item in
                jokeList.append(item.toJokeModel())
            }
            
            return jokeList
        }catch {
            return []
        }
    }
    
    func getJoke(id: String) -> JokeModelProtocol? {
        let items = getJokeEntity(id: id)
        
        for item in items ?? [] {
            if item.id == id {
                return item.toJokeModel()
            }
        }
        return nil
        
    }
    
    func saveJoke(item: JokeModelProtocol) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        
        let newItem = JokeEntity(context: context)
        newItem.id = item.id
        newItem.value = item.value
        
        do {
            try context.save()
        }catch {
            
        }
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return }
        if let jokeId = item.id, let items = getJokeEntity(id: jokeId), let item = items.first {
            context.delete(item)
            
            do {
                try context.save()
            }catch {
                
            }
        }
    }
    
    func deleteAllData()
    {
        guard ((UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.persistentStoreDescriptions.first?.url) != nil else { return }
        
        guard let persistentStoreCoordinator = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.persistentStoreCoordinator else { return }
        
        do {
            for store in persistentStoreCoordinator.persistentStores {
                try persistentStoreCoordinator.destroyPersistentStore(
                    at: store.url!,
                    ofType: store.type,
                    options: nil
                )
            }
        }catch {
            
        }
        
    }
}

extension CoreDataManager: CoreDataRepositoryManager {
    func getJokeEntity(id: String) -> [JokeEntity]? {
        do {
            guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
            
            let fetchRequest = JokeEntity.fetchRequest()
            
            fetchRequest.predicate = NSPredicate(format: "%K == %@" , "id", id)
            
            return try context.fetch(JokeEntity.fetchRequest())
            
        }catch {
            return nil
        }
    }
}
