//
//  CategoryChart.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 27/04/23.
//

import SwiftUI
import SwiftUICharts
struct CategoryChart: View {
    
    var cropedFNB = ExpenseCategory.fnb.rawValue.prefix(7)

    @State var titleCard : String = "hari"
    
    @Binding var todayDateComponent : Date
    @Binding var doughnutChartData : DoughnutChartData
    @Binding var totalExpense : Double
    @Binding var chartDisplayRange : ChartDisplayRange
    @Binding var presenter : RecapFeaturePresenter

    
    var body: some View {
        
        VStack(alignment: .center) {
            HStack{
                DoughnutChart(chartData: doughnutChartData)
                    .headerBox(chartData: doughnutChartData)
                    .legends(chartData: doughnutChartData, columns: [GridItem(.flexible()), GridItem(.flexible())])
                    .id(doughnutChartData.id)
                    .frame(minWidth: 100,
                           minHeight: 200,
                           alignment: .center)
                    .padding(.horizontal,10)
                
                VStack(alignment: .trailing){
                    Text("Pengeluaran \(titleCard) ini")
                        .foregroundColor(.black)
                        .font(.caption)
                        .fontWeight(.thin)
                    Text(currencyFormatter.string(from: NSNumber(value: totalExpense)) ?? "")
                        .foregroundColor(.primary_purple)
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.bottom,2)
                    HStack(alignment:.top){
                        HStack{
                            Text(cropedFNB)
                                .foregroundColor(.black)
                                .font(.caption2)
                            Image(systemName: "circle.fill")
                                .imageScale(.small)
                                .foregroundColor(.primary_purple)
                                .padding(.leading,-5)
                        }.frame(minWidth: 70)
                        VStack(alignment:.trailing){
                            HStack{
                                Text("\(ExpenseCategory.transport.rawValue)")
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                Image(systemName: "circle.fill")
                                    .imageScale(.small)
                                    .foregroundColor(.secondary_purple)
                                    .padding(.leading,-5)
                            }.padding(.bottom,2)
                            HStack{
                                Text("\(ExpenseCategory.item.rawValue)")
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                Image(systemName: "circle.fill")
                                    .imageScale(.small)
                                    .foregroundColor(.tertiary_purple)
                                    .padding(.leading,-5)
                            }
                        }
                        .frame(minWidth: 90)
                        .padding(.leading,-5)
                    }
                    .padding(.bottom,2)
                    .padding(.leading,15)
                    HStack{
                        Spacer()
                        Text("Jangan lupa untuk selalu mengisi kategori pengeluaran")
                            .foregroundColor(.secondary_gray)
                            .font(Font.custom("SF Pro", size: 10))
                            .multilineTextAlignment(.trailing)
                            .frame(maxWidth: 100)
                        
                    }
                    .frame(minWidth: 100, minHeight: 60)
                    .padding(6)
                    .background(
                        ZStack{
                            Color.primary_white
                            HStack{
                                VStack{
                                    Spacer()
                                    Image("beruang-welcome")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 40)
                                        .padding(.leading, 10)
                                }
                                Spacer()
                            }
                        }
                    )
                    /// to define different corner radius
                    .clipShape(
                        RoundedCorner(
                            radius: 8,
                            corners: [.topLeft,.topRight, .bottomLeft]))
                    .clipShape(
                        RoundedCorner(
                            radius: 20,
                            corners: [ .bottomRight]))
                }
            }
        }
        .frame(maxHeight: 250)
        .padding(.horizontal)
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 4, y:2)
        .onChange(of: todayDateComponent, perform: { newValue in
            presenter.fetchChartData(for: newValue, displayRange: chartDisplayRange)
            titleCard = chartDisplayRange == .day ? "hari" : "7 hari"
        })
        .onChange(of: chartDisplayRange) { newValue in
            presenter.fetchChartData(for: todayDateComponent, displayRange: newValue)
            titleCard = chartDisplayRange == .day ? "hari" : "7 hari"
        }
        
    }
    
}

//struct CategoryChart_Previews: PreviewProvider {
//    static var previews: some View {
//        CategoryChart(todayDateComponent: .constant(Date()), doughnutChartData: .constant(DoughnutChartData(
//            dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text(""))
//        ), caseDisplayRange: .constant(.day)
//        )
//        .environmentObject(coreDataViewModel())
//    }
//}
