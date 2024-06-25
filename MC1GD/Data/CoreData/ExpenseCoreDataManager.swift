//
//  CoreDataManager.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation
import CoreData

class ExpenseCoreDataManager {
    
    static let `default` = ExpenseCoreDataManager()
    private let container = PersistenceController.shared
    private init () {}
    
    func fetchExpenses(date : String) -> ([UserExpenseDTO], Double){
        let fetchRequest = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let datePredicate = NSPredicate(format : "itemAddedDate == %@", date)
        fetchRequest.predicate = datePredicate
        
        var expenseItems : [ItemEntity] = []
        do{
            try expenseItems = container.container.viewContext.fetch(fetchRequest)
        }
        catch let error{
            print(error.localizedDescription)
        }
        
        var expensesDto : [UserExpenseDTO] = []
        var totalExpense : Double = 0
        for item in expenseItems {
            totalExpense += item.itemPrice
            guard let newDto = UserExpenseDTO(from: item) else { continue }
            expensesDto.append(newDto)
        }
        return (expensesDto, totalExpense)
    }
    
    func saveExpense(expense : UserExpense){
        let newExpense = ItemEntity(context: container.container.viewContext)
        newExpense.itemId = expense.id
        newExpense.itemImage = expense.imageString
        newExpense.itemAddedDate = expense.expenseDate
        newExpense.itemPrice = expense.expensePrice.stripComma(for: expense.expensePrice)
        newExpense.itemTag = expense.expenseTag
        newExpense.itemCategory = expense.expenseCategory
        newExpense.itemDescription = expense.expenseDescription
        newExpense.itemName = expense.expenseName
        saveDbState()
    }
    
    func editExpense(expenseToEdit : UserExpense){
        let fetchRequest = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let predicate = NSPredicate(format: "itemId == %@", expenseToEdit.id)
        fetchRequest.predicate = predicate
        var existing : [ItemEntity] = []
        
        do{
            existing = try container.container.viewContext.fetch(fetchRequest)
        }
        catch let err{
            print(err.localizedDescription)
        }
        guard let expenseToBeEdited = existing.first else {return}
        expenseToBeEdited.itemImage = expenseToEdit.imageString
        expenseToBeEdited.itemAddedDate = expenseToEdit.expenseDate
        expenseToBeEdited.itemPrice = expenseToEdit.expensePrice.stripComma(for: expenseToEdit.expensePrice)
        expenseToBeEdited.itemTag = expenseToEdit.expenseTag
        expenseToBeEdited.itemCategory = expenseToEdit.expenseCategory
        expenseToBeEdited.itemDescription = expenseToEdit.expenseDescription
        expenseToBeEdited.itemName = expenseToEdit.expenseName
        saveDbState()
    }
    
    func deleteExpense(expenseId : String){
        let fetchRequest = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let predicate = NSPredicate(format: "itemId == %@", expenseId)
        fetchRequest.predicate = predicate
        var existing : [ItemEntity] = []
        
        do{
            existing = try container.container.viewContext.fetch(fetchRequest)
        }
        catch let err{
            print(err.localizedDescription)
        }
        guard let expenseToBeDeleted = existing.first else {return}
        container.container.viewContext.delete(expenseToBeDeleted)
        saveDbState()
    }
    
    private func saveDbState(){
        do{
            try container.container.viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
}
