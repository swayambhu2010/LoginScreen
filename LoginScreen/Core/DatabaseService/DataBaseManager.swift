//
//  DataBaseManager.swift
//  LoginScreen
//
//  Created by Swayambhu BANERJEE on 09/03/26.
//

import Foundation
import CoreData
import Combine

protocol DataBaseManagerProtocol {
    func saveUser(userName: String, passWord: String)
    func getAllUsers() -> [UserData]
    func deleteUser(user: UserData)
    func updateUser()
}

final class DataBaseManager: DataBaseManagerProtocol, ObservableObject {
    
    let persistentContainer: NSPersistentContainer
    
    init() {
       persistentContainer = NSPersistentContainer(name: "UserCoreDataModel")
       persistentContainer.loadPersistentStores { (description, error) in
           if let error = error {
               fatalError("Core Data Store Failed \(error.localizedDescription)")
           }
        }
    }
    
    func saveUser(userName: String, passWord: String) {
        let user = UserData(context: persistentContainer.viewContext)
        
        user.userName = userName
        user.password = passWord
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            debugPrint("Coredata saving failed")
        }
    }
    
    func getAllUsers() -> [UserData] {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        do {
            let users = try persistentContainer.viewContext.fetch(fetchRequest)
            return users
        } catch {
            print("Fetch Error")
            return []
        }
    }
    
    func deleteUser(user: UserData) {
        persistentContainer.viewContext.delete(user)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Save context failed \(error.localizedDescription)")
        }
    }
    
    func updateUser() {
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Save context failed \(error.localizedDescription)")
        }
    }
}
