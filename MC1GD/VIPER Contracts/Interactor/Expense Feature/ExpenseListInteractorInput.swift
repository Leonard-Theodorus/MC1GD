//
//  PresenterToInteractorInputProtocol.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

protocol ExpenseListInteractorInput : AnyObject {
    var output : ExpenseListInteractorOutput? {get set}
    var dataRepository : ExpenseDataRepository {get set}
    
    func fetchExpenseFromRepo(date : String)
    func editExpenseToRepo(expense : UserExpense)
    func writeExpenseToRepo(expense : UserExpense)
    func deleteExpenseToRepo(expenseId : String)
}
