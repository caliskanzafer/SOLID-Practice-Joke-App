//
//  SqliteService.swift
//  SOLID-Practice
//
//  Created by Zafer Çalışkan on 27.02.2024.
//

import Foundation
import SQLite3


final class SqliteManager {
    
    var db: OpaquePointer?
    var path: String = "solidDB.sqlite"
    
    init() {
        self.db = createDB()
        self.createTable()
    }
    
    private func createDB() -> OpaquePointer? {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
        
        var db: OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) != SQLITE_OK {
            print("DB Create Error")
            return nil
        }else {
            print("DB Created")
            return db
        }
    }
    
    private func createTable() {
        let query = "CREATE TABLE IF NOT EXISTS jokes (id TEXT PRIMARY KEY, value TEXT);"
        
        var createTable: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(self.db, query, -1, &createTable, nil) == SQLITE_OK {
            if sqlite3_step(createTable) == SQLITE_DONE {
                print("Table Created")
            }else {
                print("Table Create Error")
            }
        }else {
            print("Table Prepare Error")
        }
    }
}

extension SqliteManager: RepositoryManagerProtocol {
    func saveJoke(item: JokeModelProtocol) {
        let query = "INSERT INTO jokes (id,value) VALUES (?, ?);"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (item.id! as NSString).utf8String, -1, nil)
            sqlite3_bind_text(statement, 2, (item.value! as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Insert Success")
            }else {
                print("Insert Error")
            }
        }else {
            print("Insert Error")
        }
    }
    
    func getJokes() -> [JokeModelProtocol] {
        var mainList = [JokeModelProtocol]()
        
        let query = "SELECT * FROM jokes;"
        var statement : OpaquePointer? = nil
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK{
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(statement, 0)))
                let value = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                
                let model: JokeModelProtocol = JokeModel(id: id, value: value)
                
                
                mainList.append(model)
            }
        }
        return mainList
    }
    
    func getJoke(id: String) -> JokeModelProtocol? {
        let query = "SELECT * FROM jokes WHERE id = ?;"
        
        var statement : OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (id as NSString).utf8String, -1, nil)
            
            while sqlite3_step(statement) == SQLITE_ROW {
                let id = String(describing: String(cString: sqlite3_column_text(statement, 0)))
                let value = String(describing: String(cString: sqlite3_column_text(statement, 1)))
                
                let model: JokeModelProtocol = JokeModel(id: id, value: value)
                
                
                return model
            }
            return nil
        }else {
            return nil
        }
    }
    
    func deleteJoke(item: JokeModelProtocol) {
        let query = "DELETE FROM jokes WHERE id = ?"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            sqlite3_bind_text(statement, 1, (item.id! as NSString).utf8String, -1, nil)
            
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Delete Success")
            }else {
                print("Delete Error")
            }
        }else {
            print("Delete Error")
        }
    }
    
    func deleteAllData() {
        let query = "DELETE FROM jokes;"
        
        var statement: OpaquePointer? = nil
        
        if sqlite3_prepare_v2(db, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("Delete All Success")
            }else {
                print("Delete All Error")
            }
        }else {
            print("Delete All Error")
        }
    }
}
