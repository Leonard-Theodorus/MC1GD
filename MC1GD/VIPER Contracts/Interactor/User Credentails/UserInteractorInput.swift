//
//  UserInteractorInput.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 25/06/24.
//

import Foundation

protocol UserInteractorInput : AnyObject {
    var output : UserInteractorOutput? {get set}
    var dataRepository : UserCredentialsDataRepository {get set}
    
    func fetchUserCredentialsFromRepo()
    func writeUserCredentialsToRepo(username : String)
}
