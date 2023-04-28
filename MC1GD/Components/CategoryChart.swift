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
    private let data : DoughnutChartData = selectedData()
    var body: some View {
//        guard let data = data else {
//            return EmptyView()
//        }
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
            }
//            self.data = selectedData()
        }
        
    }
/// hapus static -> dinamis , pindahin ke viewmodel
    static func selectedData() -> DoughnutChartData {
//        var valueFNB = viewModel.calculateItemPriceCategory(for: todayDateComponent, category: categoryFNB)
//        var valueTransport = viewModel.calculateItemPriceCategory(for: todayDateComponent, category: categoryTransport)
//        var valueBarang = viewModel.calculateItemPriceCategory(for: todayDateComponent, category: categoryBarang)
        let data = PieDataSet(
            dataPoints: [
                PieChartDataPoint(value: 12000, description: "Makanan & Minuman", colour: Color(.orange), label: .label(text: "Makanan & Minuman", colour: .black)),
                PieChartDataPoint(
                    value: 3000,
                    description: "Transportasi",
                    colour: .purple,
                    label: .label(text: "Transportasi", colour: .black)),
                PieChartDataPoint(
                    value: 4000,
                    description: "Barang",
                    colour: .yellow,
                    label: .label(text: "Barang", colour: .black))
            ],
            legendTitle: "Expenses")
        
        let metadata   = ChartMetadata(title: "Expenses", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .infoBox(isStatic: false),
            infoBoxBorderColour : Color.primary,
            infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
            globalAnimation     : .easeOut(duration: 1))
        
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
