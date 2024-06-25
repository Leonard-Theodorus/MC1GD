//
//  RecapDataRepository.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation
import SwiftUICharts

class RecapDataRepository {
    private let dataManager : RecapCoreDataManager = RecapCoreDataManager.default
    
    func fetchChartData(for date : Date, displayRange : ChartDisplayRange) -> (DoughnutChartData, [BarchartData], ExpenseDetail){
        dataManager.fetchChartData(date: date, displayRange: displayRange)
    }
}
