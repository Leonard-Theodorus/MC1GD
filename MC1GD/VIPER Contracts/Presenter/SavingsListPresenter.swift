//
//  SavingsListPresenter.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

protocol SavingsListPresenter : AnyObject {
    var view : SavingPresenterToView? {get set}
    var interactor : SavingsListInteractorInput? {get set}
    
    func fetchSavings()
    func writeSavings(savingData saving : UserSaving)
}
