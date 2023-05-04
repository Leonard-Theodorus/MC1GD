//
//  SummaryView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI
import SwiftUICharts
enum displayRange : Int{
    case day = 0
    case byWeek = 1
}
struct SummaryView: View {
    @Binding var todayDateComponent : Date
    @State private var showDate = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @State var showTips = false
    @State var needsPercentage : Double = 0.0
    @State var wantsPercentage : Double = 0.0
    @State private var showPicker = false
    @State private var caseDisplayRange : displayRange = .day
    @Binding var data : DoughnutChartData
    @State var selectedMenu = "Harian"
    var body: some View {
        
        VStack(alignment: .leading){
            
            HStack(alignment: .center){
                Text("Ringkasan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                //                    Spacer()
            }
            .background(.gray)
            .padding(.leading,30)
            .padding(.top,10)
            .zIndex(1)
            
            ScrollView {
                VStack (alignment: .center){
                    HStack {
                        //MARK: BUTTON GANTI HARI/MINGGU
                        Menu(selectedMenu) {
                            Button {
                                selectedMenu = "Harian"
                                caseDisplayRange = .day
                                showPicker.toggle()
                                
                            } label :{
                                Text("Harian")
                            }
                            Button{
                                selectedMenu = "Per 7 Hari"
                                caseDisplayRange = .byWeek
                                showPicker.toggle()
                            }label:{
                                Text("Per 7 Hari")
                            }
                        }.font(.body)
                            .foregroundColor(.primary)
                            .padding(10)
                            .background(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(lineWidth: 0)
                                    .background(Color.white.cornerRadius(15)).shadow(radius: 2)
                            )
                            .frame(width: 170)
                        
                        Spacer()
                        // MARK: Customized date picker
                        ZStack{
                            Button{
                                withAnimation {
                                    showDate.toggle()
                                }
                            }label: {
                                Image(systemName: "calendar")
                                    .imageScale(.large)
                                    .foregroundColor(.primary_purple)
                            }
                            .padding(.leading,100)
                            HStack{
                                DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                                    .datePickerStyle(.graphical)
                                    .background(
                                        RoundedRectangle(cornerRadius: 20)
                                            .stroke(lineWidth: 0)
                                            .background(Color.white.cornerRadius(20))
                                            .shadow(radius: 2)
                                        
                                    )
                                    .accentColor(Color.primary_purple)
                                    .padding(10)
                                    .opacity(showDate ? 1 : 0)
                                    .offset(y:170)
                                    .frame(width: 280)
                                    .onChange(of: todayDateComponent, perform: { newValue in
                                        DispatchQueue.main.async {
                                            withAnimation {
                                                showDate.toggle()
                                                viewModel.fetchItems(for: todayDateComponent)
                                            }
                                        }
                                    })
                                
                            }.zIndex(4)
                        }
                        .frame(height:55)
                        .padding(-20)
                    }
                    .zIndex(2)
                    
                    
                    VStack{
                        // MARK: Progress bar
                        HorizontalProgressBar(needsPercentage: $needsPercentage, wantsPercentage: $wantsPercentage)
                            .frame(width: 351)
                            .padding(.horizontal)
                        
                        
                        // MARK: Category Donut chart
                        CategoryChart(todayDateComponent: $todayDateComponent, data: $data)
                        // MARK: Last7days bar chart
                        HStack{
                            NeedsWantsBarChart(needsPercentage: $needsPercentage, wantsPercentage: $wantsPercentage, todayDateComponent: $todayDateComponent).frame(width: 351 ,height: caseDisplayRange == .byWeek ? 200 : 0)
                                .padding()
                                .opacity(caseDisplayRange == .byWeek ? 1 : 0)
                        }
                        
                        if caseDisplayRange == .day{
                            NoBarChartView().frame(width: 351, height: 200).padding()
                        }
                        Button{
                            showTips.toggle()
                        }label: {
                            Text("Beberapa tips yang dapat Anda ikuti")
                                .font(.caption2)
                                .fontWeight(.bold)
                                .padding(.vertical,8)
                                .padding(.horizontal,20)
                                .foregroundColor(.white)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(lineWidth: 0)
                                        .background(Color.primary_purple.cornerRadius(20))
                                        .shadow(radius: 2, y:2)
                                        .frame(width:280)
                                )
                            
                        }.zIndex(2)
                    }
                    .zIndex(1)
                    .onTapGesture {showDate = false}
                    
                    
                    
                }
            }
            
            
        }
        .padding(.horizontal,22)
        .onAppear{
            data = viewModel.chartDummyData()
            }
        
        //        .onTapGesture {showDate = false}
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(todayDateComponent: .constant(Date()), data: .constant(DoughnutChartData(
            dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text(""))
        )
        )
        .environmentObject(coreDataViewModel())
    }
}
