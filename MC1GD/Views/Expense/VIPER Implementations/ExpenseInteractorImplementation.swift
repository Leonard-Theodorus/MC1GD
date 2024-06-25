//
//  ExpenseInteractorInputImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

class ExpenseInteractorImplementation : ExpenseListInteractorInput {
    var output: ExpenseListInteractorOutput?
    var dataRepository = ExpenseDataRepository()
    var expenseFromRepo : [UserExpense] = []
    
    
    func fetchExpenseFromRepo(date : String) {
        let (expenses, totalExpense) = dataRepository.fetchExpenses(date : date)
        output?.expenseFromRepo(expenses: expenses, totalExpense: totalExpense)
    }
    
    func writeExpenseToRepo(expense: UserExpense) {
        dataRepository.writeExpense(expense: expense)
    }
    
    func editExpenseToRepo(expense : UserExpense) {
        dataRepository.editExpense(expense: expense)
    }
    
    func deleteExpenseToRepo(expenseId: String) {
        dataRepository.deleteExpense(expenseId: expenseId)
    }
}
