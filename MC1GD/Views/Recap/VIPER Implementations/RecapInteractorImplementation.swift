//
//  RecapInteractorImplementation.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation

class RecapInteractorImplementation : RecapInteractorInput {
    var output: RecapInteractorOutput?
    
    var dataRepository: RecapDataRepository = RecapDataRepository()
    
    func fetchChartDataFromRepo(for date: Date, displayRange: ChartDisplayRange) {
        let (doughnutChartData, barChartData, expenseDetail) =
        dataRepository.fetchChartData(for: date, displayRange: displayRange)
        guard let output else {return}
        let needsPercentage = expenseDetail.needsTotal / expenseDetail.total
        let wantsPercentage = expenseDetail.wantsTotal / expenseDetail.total
        output.chartDataFromRepo(doughnutChartData: doughnutChartData, barChartData: barChartData, totalExpense: expenseDetail.total, wantsPercentage: wantsPercentage, needsPercentage: needsPercentage)
    }
    
    
}
