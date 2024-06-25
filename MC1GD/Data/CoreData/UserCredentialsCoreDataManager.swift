//
//  UserCredentialsCoreDataManager.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 25/06/24.
//

import Foundation
import CoreData

class UserCredentialsCoreDataManager {
    static let `default` : UserCredentialsCoreDataManager = UserCredentialsCoreDataManager()
    private let container = PersistenceController.shared
    private init () {}
    
    func fetchUserCredentials() -> String{
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        var users : [UserEntity] = []
        do{
            users = try container.container.viewContext.fetch(request)
        }
        catch let error{
            print(error.localizedDescription)
        }
        if users.isEmpty {
            return String()
        }
        return users.first!.username!
    }
    
    func writeUserCredentials(username : String) {
        let newUser = UserEntity(context: container.container.viewContext)
        newUser.username = username
        saveDbState()
    }
    
    private func saveDbState(){
        do{
            try container.container.viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}
