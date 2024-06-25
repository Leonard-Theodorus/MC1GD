//
//  SavingsListInteractorImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation

class SavingsListInteractorImplementation : SavingsListInteractorInput{
    
    var dataRepository: SavingsDataRepository = SavingsDataRepository()
    var output: SavingsListInteractorOutput?
    
    func fetchSavingsFromRepo() {
        let (savings, totalSavings) = dataRepository.fetchSavings()
        guard let output else {return}
        output.savingsFromRepo(savings: savings, totalSavings: totalSavings)
    }
    
    func writeSavingsToRepo(savingData saving: UserSaving) {
        dataRepository.writeSavingsToDb(savingData: saving)
    }
    
}
