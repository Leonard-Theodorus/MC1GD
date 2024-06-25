//
//  UserExpenseDTO.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 18/06/24.
//

import Foundation

struct UserExpenseDTO {
    let expenseId : String
    let imageString : String
    
    var expenseName : String
    var expensePrice : Double
    var expenseDate : String
    var expenseCategory : String
    var expenseDescription : String
    var expenseTag : String
    
    
    init?(from itemEntity : ItemEntity){
        guard let id = itemEntity.itemId,
              let image = itemEntity.itemImage,
              let expenseName = itemEntity.itemName,
              let expenseDate = itemEntity.itemAddedDate,
              let expenseCategory = itemEntity.itemCategory,
              let expenseDescription = itemEntity.itemDescription,
              let expenseTag = itemEntity.itemTag
        else { return nil}
              
              
        self.expenseId = id
        self.imageString = image
        self.expenseName = expenseName
        self.expenseDate = expenseDate
        self.expenseTag = expenseTag
        self.expenseCategory = expenseCategory
        self.expenseDescription = expenseDescription
        self.expenseTag = expenseTag
        self.expensePrice = itemEntity.itemPrice
    }
}
