//
//  DataRepository.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

class ExpenseDataRepository {
    private let dataManager : ExpenseCoreDataManager = ExpenseCoreDataManager.default
    
    func fetchExpenses(date : String) -> ([UserExpense], Double) {
        let (fetchedExpensesDto, totalExpense) = dataManager.fetchExpenses(date : date)
        var expenses : [UserExpense] = []
        for dto in fetchedExpensesDto {
            let newExpense = UserExpense(from: dto)
            expenses.append(newExpense)
        }
        return (expenses, totalExpense)
    }
    
    func writeExpense(expense : UserExpense){
        dataManager.saveExpense(expense: expense)
    }
    
    func editExpense(expense : UserExpense){
        dataManager.editExpense(expenseToEdit: expense)
    }
    
    func deleteExpense(expenseId : String){
        dataManager.deleteExpense(expenseId: expenseId)
    }
}
