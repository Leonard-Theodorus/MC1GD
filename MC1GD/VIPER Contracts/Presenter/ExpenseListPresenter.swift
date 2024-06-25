//
//  ExpenseListPresenter.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 18/06/24.
//

import Foundation

protocol ExpenseListPresenter : AnyObject {
    var view : ExpensePresenterToView? {get set}
    var interactor : ExpenseListInteractorInput? {get set}
    
    func fetchExpense(date : String)
    func editExpense(expense : UserExpense)
    func writeExpense(expense : UserExpense)
    func deleteExpense(expenseId : String, date : String)
    
}
