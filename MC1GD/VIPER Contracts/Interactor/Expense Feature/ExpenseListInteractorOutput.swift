//
//  InteractorToPresenterOutputProtocol.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

protocol ExpenseListInteractorOutput: AnyObject {
    func expenseFromRepo(expenses : [UserExpense], totalExpense : Double )
}
