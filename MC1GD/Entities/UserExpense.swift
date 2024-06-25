//
//  UserExpense.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

struct UserExpense : Identifiable{
    let id : String
    
    var imageString : String
    var expenseName : String
    var expensePrice : String
    var expenseDate : String
    var expenseCategory : String
    var expenseDescription : String
    var expenseTag : String
    
    init(id : String, expenseName : String, expensePrice : String, expenseDate : Date,
         expenseCategory : ExpenseCategory, expenseDesc : String, expenseTag : String){
        self.id = id
        self.expenseTag = expenseTag
        self.expenseName = expenseName
        self.expensePrice = expensePrice
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let expenseDate = dateFormatter.string(from: expenseDate)
        
        switch expenseCategory{
            case .fnb:
                self.imageString = "fork.knife"
            case .transport:
                self.imageString = "tram.fill"
            case .item:
                self.imageString = "bag"
        }
        
        self.expenseDate = expenseDate
        self.expenseCategory = expenseCategory.rawValue
        self.expenseDescription = expenseDesc
    }
    
    init(from dto : UserExpenseDTO){
        self.id = dto.expenseId
        
        self.imageString = dto.imageString
        self.expenseName = dto.expenseName
        self.expenseDate = dto.expenseDate
        self.expenseCategory = dto.expenseCategory
        self.expenseDescription = dto.expenseDescription
        self.expenseTag = dto.expenseTag
        self.expenseDate = dto.expenseDate
        self.expensePrice = currencyFormatter.string(from: NSNumber(floatLiteral: dto.expensePrice)) ?? ""
    }
    
}
