//
//  SavingsListPresenterImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation

class SavingsListPresenterImplementation : SavingsListPresenter {
    
    var view: SavingPresenterToView?
    
    var interactor: SavingsListInteractorInput?
    
    func fetchSavings() {
        guard let interactor else {return}
        interactor.fetchSavingsFromRepo()
    }
    
    func writeSavings(savingData saving: UserSaving) {
        guard let interactor else {return}
        interactor.writeSavingsToRepo(savingData: saving)
        interactor.fetchSavingsFromRepo()
    }
}

extension SavingsListPresenterImplementation : SavingsListInteractorOutput{
    func savingsFromRepo(savings: [UserSaving], totalSavings: Double) {
        guard let view else {return}
        view.finishLoading(savings: savings, totalSavings: totalSavings)
    }
}

