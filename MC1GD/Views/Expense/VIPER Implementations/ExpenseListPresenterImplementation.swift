//
//  ExpenseListPresenterImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

class ExpenseListPresenterImplementation : ExpenseListPresenter{
    var view: ExpensePresenterToView?
    var interactor : ExpenseListInteractorInput?
    
    init(view: ExpensePresenterToView, interactor: ExpenseListInteractorInput) {
        self.view = view
        self.interactor = interactor
        interactor.output = self
    }
    
    init(view : ExpensePresenterToView? = nil, interactor : ExpenseListInteractorInput? = nil){
        
    }
    
    func fetchExpense(date : String) {
        guard let interactor else {return}
        interactor.fetchExpenseFromRepo(date: date)
    }
    
    func editExpense(expense : UserExpense) {
        guard let interactor else {return}
        interactor.editExpenseToRepo(expense : expense)
        interactor.fetchExpenseFromRepo(date: expense.expenseDate)
        
    }
    
    func writeExpense(expense: UserExpense) {
        guard let interactor else {return}
        interactor.writeExpenseToRepo(expense: expense)
        interactor.fetchExpenseFromRepo(date: expense.expenseDate)
    }
    
    func deleteExpense(expenseId: String, date : String) {
        guard let interactor else {return}
        interactor.deleteExpenseToRepo(expenseId: expenseId)
        interactor.fetchExpenseFromRepo(date: date)
    }
    
}

extension ExpenseListPresenterImplementation : ExpenseListInteractorOutput{
    func expenseFromRepo(expenses: [UserExpense], totalExpense: Double) {
        guard let view else {return}
        view.finishLoading(expenses: expenses, totalExpense: totalExpense)
    }
    
}
