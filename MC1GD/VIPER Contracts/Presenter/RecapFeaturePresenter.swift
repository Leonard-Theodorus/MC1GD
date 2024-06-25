//
//  RecapFeaturePresenter.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation

protocol RecapFeaturePresenter : AnyObject {
    var view : RecapPresenterToView? {get set}
    var interactor : RecapInteractorInput? {get set}
    
    func fetchChartData(for date : Date, displayRange : ChartDisplayRange)
}
