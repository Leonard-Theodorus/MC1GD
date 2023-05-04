//
//  RootView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI
import SwiftUICharts
struct RootView: View {
    
    @State var selectedTab : Tabs = .expense
    @State private var todayDateComponent = Date()
    @EnvironmentObject var viewModel: coreDataViewModel
    @State var data : DoughnutChartData
    var body: some View {
        VStack{
            if(viewModel.checkEmptyUsername()){
                WelcomeScreen()
                    .onAppear{
                        viewModel.fetchUser()
                    }
                    .onDisappear{
                        notificationModel.instance.setupNotifications(username: viewModel.getName())
                    }
                    
            }else{
                if selectedTab == .summary {
                    SummaryView(todayDateComponent: $todayDateComponent, data: $data)
                }else if selectedTab == .expense {
                    //                ExpenseView(todayDateComponent: $todayDateComponent)
                    ExpenseViewTemp(todayDateComponent: $todayDateComponent)
                }
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .onAppear{
            data = viewModel.chartDummyData()
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(data:
                    DoughnutChartData(
                        dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text("")))
        .environmentObject(coreDataViewModel())
    }
}
