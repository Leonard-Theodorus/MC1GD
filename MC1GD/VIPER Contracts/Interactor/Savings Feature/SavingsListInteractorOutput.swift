//
//  SavingsListInteractorOutput.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 20/06/24.
//

import Foundation

protocol SavingsListInteractorOutput : AnyObject{
    func savingsFromRepo(savings : [UserSaving], totalSavings : Double)
}
