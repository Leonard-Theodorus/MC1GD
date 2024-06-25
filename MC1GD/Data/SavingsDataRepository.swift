//
//  SavingsDataRepository.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation

class SavingsDataRepository {
    private let dataManager : SavingsCoreDataManager = SavingsCoreDataManager.default
    
    func fetchSavings() -> ([UserSaving], Double){
        let (fetchedSavingsDto, totalSavings) = dataManager.fetchSavings()
        var userSavings : [UserSaving] = []
        for saving in fetchedSavingsDto{
            let userSaving = UserSaving(from: saving)
            userSavings.append(userSaving)
        }
        return(userSavings, totalSavings)
    }
    
    func writeSavingsToDb(savingData saving : UserSaving){
        dataManager.writeSavingData(savings: saving)
    }
}
