//
//  CategoryChart.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 27/04/23.
//

import SwiftUI
import SwiftUICharts


struct CategoryChart: View {
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var todayDateComponent : Date
    @State var data : DoughnutChartData = selectedData()
    var body: some View {
        HStack{
            DoughnutChart(chartData: data)
                .headerBox(chartData: data)
                .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible())])
                .id(data.id)
                .frame(maxWidth: 300,
                       maxHeight: 300,
                       alignment: .center)
                .touchOverlay(chartData: data)
            
        }
        .padding(.leading,50)
        .onAppear{
            withAnimation {
                viewModel.fetchItems(for: todayDateComponent)
                data = viewModel.getChartData(for: todayDateComponent)
            }
        }
        .onChange(of: todayDateComponent, perform: { newValue in
            print(todayDateComponent)
            withAnimation {
                viewModel.fetchItems(for: todayDateComponent)
                data = viewModel.getChartData(for: todayDateComponent)
            }
        })
        
    }
    static func selectedData() -> DoughnutChartData {
        let data = PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: "")
            
        
        let metadata   = ChartMetadata(title: "Expenses", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .infoBox(isStatic: false),
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

struct CategoryChart_Previews: PreviewProvider {
    static var previews: some View {
        CategoryChart(todayDateComponent: .constant(Date()))
    }
}
