//
//  PieChart.swift
//  MC1
//
//  Created by Leonard Theodorus on 23/04/23.
//

import SwiftUI
import SwiftUICharts

struct PieChart: View {
    var body: some View {
        PieChartView(data: [10, 20, 30, 40], title: "Expenses This Month", dropShadow: false)
    }
}

struct PieChart_Previews: PreviewProvider {
    static var previews: some View {
        PieChart()
    }
}
