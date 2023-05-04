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
    @State var chartData : [barChartData] = []
    @State var uniqueDates : [Date] = []
    @State var chartDate : [Date] = []
    @Binding var needsPercentage : Double
    @Binding var wantsPercentage : Double
    @Binding var todayDateComponent : Date
    @State var total : Double = 0
    @State var needsTotal : Double = 0
    @State var wantsTotal : Double = 0
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
                .onChange(of: todayDateComponent, perform: { newValue in
                    DispatchQueue.main.async {
                        withAnimation {
                            chartData = viewModel.getLastSevenDaysData(startFrom: todayDateComponent)
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
                            uniqueDates = []
                            chartDate = []
                            uniqueDates = chartData.map({$0.date})
                            for date in uniqueDates{
                                let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
                                chartDate.append(correctDate)
                                
                            }
                        }
                    }
                })
                .onAppear{
                    DispatchQueue.main.async {
                        withAnimation {
                            chartData = viewModel.getLastSevenDaysData(startFrom: todayDateComponent)
                            guard chartData.count != 0 else{
                                needsPercentage = 0
                                wantsPercentage = 0
                                return
                            }
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
                            uniqueDates = []
                            chartDate = []
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
        }.frame(maxHeight: 350)
            .padding()
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(radius: 4, y:2)
    }
    
}

struct NeedsWantsBarChart_Previews: PreviewProvider {
    static var previews: some View {
        NeedsWantsBarChart(needsPercentage: .constant(50), wantsPercentage: .constant(50), todayDateComponent: .constant(Date())).environmentObject(coreDataViewModel())
    }
}
