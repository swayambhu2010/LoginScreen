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
    func saveUser(userModel: LoginModel)
    func getAllUsers() -> [LoginModel]
    func deleteUser(user: LoginModel)
    func updateUser(user: LoginModel) throws -> Bool
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

    func saveUser(userModel: LoginModel) {
        let user = UserData(context: persistentContainer.viewContext)
        
        user.userName = userModel.username
        user.password = userModel.password
        user.userId = userModel.uuid
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            debugPrint("Coredata saving failed")
        }
    }
    
    func getAllUsers() -> [LoginModel] {
        let fetchRequest: NSFetchRequest<UserData> = UserData.fetchRequest()
        do {
            let users = try persistentContainer.viewContext.fetch(fetchRequest)
            print("All users \(users)")
            let userModels = users.map { user in
                return LoginModel(username: user.userName ?? "", password: user.password ?? "", uuid: user.userId ?? UUID())
            }
            return userModels
        } catch {
            print("Fetch Error")
            return []
        }
    }
    
    func deleteUser(user: LoginModel) {
        let id = user.uuid
        guard let user = fetchUser(id: id) else { return }
        persistentContainer.viewContext.delete(user)
        
        do {
            try persistentContainer.viewContext.save()
        } catch {
            persistentContainer.viewContext.rollback()
            print("Save context failed \(error.localizedDescription)")
        }
    }
    
    func updateUser(user: LoginModel) throws -> Bool {
            let id = user.uuid
            guard let userData = fetchUser(id: id) else {
                throw DataBaseError.fetchError
        }
        userData.userName = user.username
        
        do {
            try persistentContainer.viewContext.save()
            return true
        } catch {
            persistentContainer.viewContext.rollback()
            throw DataBaseError.saveError
        }
    }
    
    func fetchUser(id: UUID) -> UserData? {
        let fetchRequest : NSFetchRequest<UserData> = UserData.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "userId == %@", id as CVarArg)
        fetchRequest.fetchLimit = 1
        return try? persistentContainer.viewContext.fetch(fetchRequest).first
    }
}
