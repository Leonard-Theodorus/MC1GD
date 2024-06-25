//
//  NeedsWantsBarChart.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 30/04/23.
//

import SwiftUI
import Charts
struct NeedsWantsBarChart: View {
    @Binding var chartData : [BarchartData]
    @Binding var todayDateComponent : Date
    @Binding var chartDisplayRange : ChartDisplayRange
    @Binding var presenter : RecapFeaturePresenter
    
    @State var uniqueDates : [Date] = []
    @State var chartDate : [Date] = []
    
    var body: some View {
        VStack(alignment: .center) {
            Text("Rekap 7 Hari Kebelakang")
                .font(.caption)
                .fontWeight(.thin)
                .foregroundColor(.primary)
                .padding(.leading, 20)
            HStack(alignment: .center){
                Chart(chartData, id: \.id){
                    BarMark(
                        x: .value("Day", $0.date, unit: .day),
                        y: .value("Price", $0.expense)
                    )
                    .foregroundStyle(by: .value("Tag", $0.tag))
                    
                }
                .chartLegend(content: {
                    HStack(alignment : .center) {
                        Circle().fill(Color.tag_purple).frame(width: 10, height: 10)
                        Text("Kebutuhan").font(.caption).foregroundColor(.primary)
                        Circle().fill(Color.tag_pink).frame(width: 10, height: 10)
                        Text("Keinginan").font(.caption).foregroundColor(.primary)
                    }
                })
                .chartForegroundStyleScale([
                    "Keinginan": Color.tag_pink,
                    "Kebutuhan": Color.tag_purple
                ])
                .onAppear{
                    chartDate = []
                    uniqueDates = chartData.map({$0.date})
                    for date in uniqueDates{
                        let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        chartDate.append(correctDate)
                    }
                }
                .onChange(of: chartDisplayRange, perform: { newValue in
                    DispatchQueue.main.async {
                        presenter.fetchChartData(for: todayDateComponent, displayRange: chartDisplayRange)
                    }
                    chartDate = []
                    uniqueDates = chartData.map({$0.date})
                    for date in uniqueDates{
                        let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        chartDate.append(correctDate)
                    }

                })
                .onChange(of: todayDateComponent, perform: { newValue in
                    DispatchQueue.main.async {
                        presenter.fetchChartData(for: todayDateComponent, displayRange: chartDisplayRange)
                    }
                    chartDate = []
                    uniqueDates = chartData.map({$0.date})
                    for date in uniqueDates{
                        let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                        chartDate.append(correctDate)
                    }

                })
                .chartXAxis{
                    AxisMarks(values: chartDate.unique.sorted()) {
                        AxisValueLabel(centered: true)
                    }
                }
                .chartYAxis(.hidden)
                
            }
        }
        .frame(maxHeight: 350)
        .padding()
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 4, y:2)
    }
    
}

//struct NeedsWantsBarChart_Previews: PreviewProvider {
//    static var previews: some View {
//        NeedsWantsBarChart(needsPercentage: .constant(50), wantsPercentage: .constant(50), todayDateComponent: .constant(Date()), caseDisplayRange: .constant(.day)).environmentObject(coreDataViewModel())
//    }
//}

