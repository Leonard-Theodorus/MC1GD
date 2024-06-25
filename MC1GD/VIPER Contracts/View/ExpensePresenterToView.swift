//
//  ExpensePresenterToView.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

protocol ExpensePresenterToView{
    func finishLoading(expenses : [UserExpense], totalExpense : Double)
}
