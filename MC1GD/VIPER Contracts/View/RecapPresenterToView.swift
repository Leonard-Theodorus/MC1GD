//
//  RecapPresenterToView.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation
import SwiftUICharts

protocol RecapPresenterToView {
    func finishLoading(doughnutChartData : DoughnutChartData, barChartData : [BarchartData], 
                       totalExpense : Double, wantsPercentage : Double, needsPercentage : Double
    )
}
