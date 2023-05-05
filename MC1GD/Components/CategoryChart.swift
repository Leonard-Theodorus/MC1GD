//
//  CategoryChart.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 27/04/23.
//

import SwiftUI
import SwiftUICharts
struct CategoryChart: View {
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var todayDateComponent : Date
    @Binding var data : DoughnutChartData
    @State var allExpense : Double = 0
    @State var cropedFNB = category.FNB.rawValue.prefix(7)
    @Binding var caseDisplayRange : displayRange
    var body: some View {
        
        VStack(alignment: .center) {
            HStack{
                DoughnutChart(chartData: data)
                    .headerBox(chartData: data)
                    .legends(chartData: data, columns: [GridItem(.flexible()), GridItem(.flexible())])
                    .id(data.id)
                    .frame(minWidth: 100,
                           minHeight: 200,
                           alignment: .center)
                    .padding(.horizontal,10)
                
                VStack(alignment: .trailing){
                    Text("Pengeluaran hari ini")
                        .foregroundColor(.black)
                        .font(.caption)
                        .fontWeight(.thin)
                    Text(currencyFormatter.string(from: NSNumber(value: allExpense)) ?? "")
                        .foregroundColor(.primary_purple)
                        .font(.title)
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
                                Text("\(category.transport.rawValue)")
                                    .foregroundColor(.black)
                                    .font(.caption2)
                                Image(systemName: "circle.fill")
                                    .imageScale(.small)
                                    .foregroundColor(.secondary_purple)
                                    .padding(.leading,-5)
                            }.padding(.bottom,2)
                            HStack{
                                Text("\(category.barang.rawValue)")
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
                        //                                .font(.caption2)
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
        .onAppear{
            if caseDisplayRange == .day{
                withAnimation {
                    DispatchQueue.main.async {
                        viewModel.fetchItems(for: todayDateComponent)
                        data = viewModel.getChartData(for: todayDateComponent)
                        allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                    }
                    
                }
            }
            
        }
        .onChange(of: todayDateComponent, perform: { newValue in
            if caseDisplayRange == .day{
                withAnimation {
                    DispatchQueue.main.async {
                        viewModel.fetchItems(for: todayDateComponent)
                        data = viewModel.getChartData(for: todayDateComponent)
                        allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                    }
                    
                }
            }
            else{
                withAnimation {
                    DispatchQueue.main.async {
                        data = viewModel.getLastSevenDaysDonutData(startFrom: todayDateComponent)
                        allExpense = viewModel.calculateAllExpense(for: todayDateComponent, by: .byWeek)
                    }
                    
                }
            }
            
        })
        .onChange(of: caseDisplayRange) { newValue in
            if newValue == .byWeek{
                withAnimation {
                    DispatchQueue.main.async {
                        data = viewModel.getLastSevenDaysDonutData(startFrom: todayDateComponent)
                        allExpense = viewModel.calculateAllExpense(for: todayDateComponent, by: .byWeek)
                    }
                    
                }
            }
            else{
                withAnimation {
                    DispatchQueue.main.async {
                        viewModel.fetchItems(for: todayDateComponent)
                        data = viewModel.getChartData(for: todayDateComponent)
                        allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                    }
                    
                }
            }
        }
        
    }
    
}

struct CategoryChart_Previews: PreviewProvider {
    static var previews: some View {
        CategoryChart(todayDateComponent: .constant(Date()), data: .constant(DoughnutChartData(
            dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text(""))
        ), caseDisplayRange: .constant(.day)
        )
        .environmentObject(coreDataViewModel())
    }
}
