//
//  UserFeaturePresenter.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 25/06/24.
//

import Foundation

protocol UserCredentialsPresenter : AnyObject {
    var view : UserPresenterToView? {get set}
    var interactor : UserInteractorInput? {get set}
    
    func fetchUserCredentials()
    func writeUserCredentials(username : String)
}
