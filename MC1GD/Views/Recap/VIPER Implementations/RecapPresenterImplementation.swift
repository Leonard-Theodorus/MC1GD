//
//  RecapPresenterImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation
import SwiftUICharts

class RecapPresenterImplementation : RecapFeaturePresenter {
    
    var view: RecapPresenterToView?
    var interactor: RecapInteractorInput?
    
    func fetchChartData(for date: Date, displayRange: ChartDisplayRange) {
        guard let interactor else {return}
        interactor.fetchChartDataFromRepo(for: date, displayRange: displayRange)
    }
}

extension RecapPresenterImplementation : RecapInteractorOutput {
    func chartDataFromRepo(doughnutChartData: SwiftUICharts.DoughnutChartData, barChartData: [BarchartData], 
                           totalExpense: Double, wantsPercentage: Double, needsPercentage: Double
    ) {
        guard let view else {return}
        view.finishLoading(doughnutChartData: doughnutChartData, barChartData: barChartData, totalExpense: totalExpense, wantsPercentage: wantsPercentage, needsPercentage: needsPercentage)
    }
    
}
