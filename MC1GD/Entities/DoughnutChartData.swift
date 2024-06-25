//
//  DoughnutChartData.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation
import SwiftUI
import SwiftUICharts

extension DoughnutChartData {
    static func dummy() -> DoughnutChartData {
        let data = PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: "")
        
        let metadata = ChartMetadata(title: "", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .floating,
            infoBoxContentAlignment : .horizontal,
            infoBoxDescriptionFont : .footnote,
            infoBoxBorderColour : Color.primary,
            infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
            globalAnimation     : .easeOut(duration: 1)
        )
        
        return DoughnutChartData(
            dataSets       : data,
            metadata       : metadata,
            chartStyle     : chartStyle,
            noDataText     : Text("No Data")
        )
    }
}
