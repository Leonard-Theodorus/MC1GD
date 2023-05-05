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
    @Binding var data : DoughnutChartData
    @State private var showDate = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @State var showTips = false
    @State var needsPercentage : Double = 0.0
    @State var wantsPercentage : Double = 0.0
    @State private var showPicker = false
    @State private var caseDisplayRange : displayRange = .day
    @State var selectedMenu = "Harian"
    var body: some View {
        
        NavigationView {
            VStack(alignment: .center){
                HStack(alignment: .center){
                    Text("Ringkasan")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    Spacer()
                }
                
                
                VStack (alignment: .center){
                    HStack(alignment: .center){
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
                                    .offset(x:-110, y:170)
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
                        .frame(width: 25,height:30)
                    }
                    .zIndex(2)
                    .padding(.bottom,5)
                    
                    VStack{
                        // MARK: Progress bar
                        HorizontalProgressBar(needsPercentage: $needsPercentage, wantsPercentage: $wantsPercentage)
                        
                        // MARK: Category Donut chart
                        CategoryChart(todayDateComponent: $todayDateComponent, data: $data)
                            .padding(.vertical,6)
                        
                        // MARK: Last7days bar chart
                        if caseDisplayRange == .day{
                            NoBarChartView()
                                .frame(height: 200)
                        }else{
                            HStack{
                                NeedsWantsBarChart(needsPercentage: $needsPercentage, wantsPercentage: $wantsPercentage, todayDateComponent: $todayDateComponent).frame(height: caseDisplayRange == .byWeek ? 200 : 0)
                                    .opacity(caseDisplayRange == .byWeek ? 1 : 0)
                            }
                        }
                        
                        NavigationLink(destination: TipsView(todayDateComponent: $todayDateComponent, data: $data)) {
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
                            
                                .padding(.vertical,15)
                        }
                        
                    }
                    .padding(.vertical,15)
                    .zIndex(1)
                    
                }
                
            }
            .padding(.horizontal,22)
            .onAppear{
                data = viewModel.chartDummyData()
            }
        }
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(todayDateComponent: .constant(Date()), data: .constant(DoughnutChartData(
            dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text("")))
        )
        .environmentObject(coreDataViewModel())
    }
}
