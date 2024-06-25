//
//  UserSaving.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

struct UserSaving : Identifiable{
    let id : String
    
    var savingAmount : Double
    var dateAdded : String
    
    init(from dto : UserSavingDTO){
        self.id = dto.savingId
        self.savingAmount = dto.savingAmount
        self.dateAdded = dto.dateAdded
    }
    init(savingAmount : Double, dateAdded : Date){
        self.id = UUID().uuidString
        self.savingAmount = savingAmount
        self.dateAdded = dateAdded.formateSavingsDate(for: dateAdded)
    }
}
