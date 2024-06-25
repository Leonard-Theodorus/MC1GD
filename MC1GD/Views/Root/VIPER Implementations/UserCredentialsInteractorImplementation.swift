//
//  UserCredentialsInteractorImplementations.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 25/06/24.
//

import Foundation

class UserCredentialsInteractorImplementation : UserInteractorInput {
    var output: UserInteractorOutput?
    
    var dataRepository: UserCredentialsDataRepository = UserCredentialsDataRepository()
    
    func fetchUserCredentialsFromRepo() {
        guard let output else {return}
        let username = dataRepository.fetchUserCredentials()
        output.userCredentialsFromRepo(username: username)
    }
    
    func writeUserCredentialsToRepo(username: String) {
        dataRepository.writeUserCredentials(username: username)
    }
    
    
}
