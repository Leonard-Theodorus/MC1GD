//
//  SavingsListInteractorInput.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

protocol SavingsListInteractorInput : AnyObject {
    var output : SavingsListInteractorOutput? {get set}
    var dataRepository : SavingsDataRepository {get set}
    func fetchSavingsFromRepo()
    func writeSavingsToRepo(savingData saving : UserSaving)
}
