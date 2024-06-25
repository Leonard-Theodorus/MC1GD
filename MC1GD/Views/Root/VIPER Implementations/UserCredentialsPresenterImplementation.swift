//
//  UserCredentialsPresenterImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 25/06/24.
//

import Foundation

class UserCredentialsPresenterImplementation : UserCredentialsPresenter{
    var view: UserPresenterToView?
    
    var interactor: UserInteractorInput?
    
    func fetchUserCredentials() {
        guard let interactor else {return}
        interactor.fetchUserCredentialsFromRepo()
    }
    
    func writeUserCredentials(username: String) {
        guard let interactor else {return}
        interactor.writeUserCredentialsToRepo(username: username)
        interactor.fetchUserCredentialsFromRepo()
    }
}
extension UserCredentialsPresenterImplementation : UserInteractorOutput{
    func userCredentialsFromRepo(username: String) {
        guard let view else {return}
        view.finishLoading(username: username)
    }
}
