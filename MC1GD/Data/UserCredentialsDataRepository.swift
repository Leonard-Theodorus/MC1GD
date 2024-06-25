//
//  UserCredentialsDataRepository.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 25/06/24.
//

import Foundation

class UserCredentialsDataRepository {
    private let dataManager : UserCredentialsCoreDataManager = UserCredentialsCoreDataManager.default
    
    func fetchUserCredentials() -> String{
        dataManager.fetchUserCredentials()
    }
    
    func writeUserCredentials(username : String){
        dataManager.writeUserCredentials(username: username)
    }
}
