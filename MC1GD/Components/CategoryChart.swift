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
    @State var allExpense : Double = 0
    var body: some View {
        VStack (alignment:.center){
            HStack{
                DoughnutChart(chartData: data)
                    .headerBox(chartData: data)
                    .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible())])
                    .id(data.id)
                    .frame(width: 180,
                           height: 200,
                           alignment: .center)
//                    .touchOverlay(chartData: data)
                VStack(alignment: .leading){
                    Text("Pengeluaran bulan ini")
                        .foregroundColor(.black)
                        .font(.caption)
                    Text(currencyFormatter.string(from: NSNumber(value: allExpense)) ?? "")
                        .foregroundColor(Color("primary-purple"))
                        .font(.title)
                    HStack{
                        Image(systemName: "circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color("primary-orange"))
                        Text("\(category.FNB.rawValue)")
                            .foregroundColor(.black)
                            .font(.caption2)
                    }.padding(.vertical,2)
                    HStack{
                        Image(systemName: "circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color("primary-purple"))
                        Text("\(category.transport.rawValue)")
                            .foregroundColor(.black)
                            .font(.caption2)
                    }.padding(.bottom,2)
                    HStack{
                        Image(systemName: "circle.fill")
                            .imageScale(.medium)
                            .foregroundColor(Color("primary-green"))
                        Text("\(category.barang.rawValue)")
                            .foregroundColor(.black)
                            .font(.caption2)
                    }
                }
                
            }
            .frame(minWidth:351, maxHeight: 250)
            .background(Color(.white))
            .cornerRadius(20)
            .shadow(radius: 4, y:8)
            .onAppear{
                withAnimation {
                    viewModel.fetchItems(for: todayDateComponent)
                    data = viewModel.getChartData(for: todayDateComponent)
                    allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                }
            }
            .onChange(of: todayDateComponent, perform: { newValue in
                print(todayDateComponent)
                withAnimation {
                    viewModel.fetchItems(for: todayDateComponent)
                    data = viewModel.getChartData(for: todayDateComponent)
                    allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                }
        })
        }
        
    }
    
    static func selectedData() -> DoughnutChartData {
        let data = PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: "")
            
        let metadata   = ChartMetadata(title: "", subtitle: "")
        
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

struct CategoryChart_Previews: PreviewProvider {
    static var previews: some View {
        CategoryChart(todayDateComponent: .constant(Date()))
    }
}
