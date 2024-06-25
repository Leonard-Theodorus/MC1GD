//
//  UserSavingDTO.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 18/06/24.
//

import Foundation

struct UserSavingDTO {
    let savingId : String
    
    var savingAmount : Double
    var dateAdded : String
    
    init?(from saving : SavingEntity){
        guard let savingId = saving.savingId,
              let dateAdded = saving.savingDate
        else {return nil}
        self.savingId = savingId
        self.savingAmount = saving.savingAmount
        self.dateAdded = dateAdded
    }
}
