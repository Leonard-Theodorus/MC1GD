//
//  NeedsWantsBarChart.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 30/04/23.
//

import SwiftUI
import Charts
struct NeedsWantsBarChart: View {
    @EnvironmentObject var viewModel : coreDataViewModel
    @State var chartData : [barChartData] = [
        .init(day: "20230502", expense: 2000, tag: "Keinginan"),
        .init(day: "20230502", expense: 3000, tag: "Keinginan"),
        .init(day: "20230502", expense: 4000, tag: "Kebutuhan")
        
    ]
    @State var uniqueDates : [Date] = []
    @State var chartDate : [Date] = []
    @Binding var needsPercentage : Double
    @Binding var wantsPercentage : Double
    @State var total : Double = 0
    @State var needsTotal : Double = 0
    @State var wantsTotal : Double = 0
    var body: some View {
        VStack(alignment: .leading) {
            Text("Rekap harianmu selama tujuh hari terakhir")
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
                        Circle().fill(Color.primary_purple).frame(width: 10, height: 10)
                        Text("Kebutuhan").font(.caption).foregroundColor(.primary)
                        Circle().fill(Color.secondary_purple).frame(width: 10, height: 10)
                        Text("Keinginan").font(.caption).foregroundColor(.primary)
                    }
                })
                .chartForegroundStyleScale([
                     "Kebutuhan": Color("primary-purple"), "Keinginan": Color("secondary-purple")
                ])
                .onAppear{
                    DispatchQueue.main.async {
                        withAnimation {
                            chartData = viewModel.getLastSevenDaysData(startFrom: Date())
                            for item in chartData{
                                if item.tag == "Keinginan"{
                                    wantsTotal += item.expense
                                }
                                else{
                                    needsTotal += item.expense
                                }
                            }
                            total = wantsTotal + needsTotal
                            needsPercentage = needsTotal / total
                            wantsPercentage = wantsTotal / total
                            uniqueDates = chartData.map({$0.date})
                            for date in uniqueDates{
                                let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                                chartDate.append(correctDate)
                                
                            }
                        }
                    }
                    
                    
                }
                .chartXAxis{
                    AxisMarks(values: chartDate.unique.sorted()) {
                        AxisValueLabel(centered: true)
                    }
                }
                .chartYAxis(.hidden)
                
            }
        }.frame(maxWidth:351, maxHeight: 350)
            .padding()
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(radius: 4, y:8)
    }
    
}

struct NeedsWantsBarChart_Previews: PreviewProvider {
    static var previews: some View {
        NeedsWantsBarChart(needsPercentage: .constant(50), wantsPercentage: .constant(50)).environmentObject(coreDataViewModel())
    }
}
