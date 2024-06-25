//
//  RootView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI
import SwiftUICharts
struct RootView: View {
    
    @State var selectedTab : PageEnum = .expense
    @State private var todayDateComponent = Date()
    @State var username : String = ""
    
    var userCredentialsPresenter : UserCredentialsPresenter = UserCredentialsPresenterImplementation()
    var expenseFeaturePresenter : ExpenseListPresenter = ExpenseListPresenterImplementation()
    var savingsFeaturePresenter : SavingsListPresenter = SavingsListPresenterImplementation()
    var recapFeaturePresenter : RecapFeaturePresenter = RecapPresenterImplementation()
    
    var body: some View {
        VStack{
            if(username == ""){
                WelcomeScreen(presenter: userCredentialsPresenter)
                    .onDisappear{
                        NotificationManager.instance.setupNotifications(username: username)
                    }
                    
            }else{
                if selectedTab == .summary {
                    SummaryView(todayDateComponent: $todayDateComponent, presenter: recapFeaturePresenter)
                }else if selectedTab == .expense {
                    ExpenseView(presenter: expenseFeaturePresenter, todayDateComponent: $todayDateComponent, userName: $username)
                }else if selectedTab == .tabungan{
                    SavingsView(presenter: savingsFeaturePresenter,todayDateComponent: $todayDateComponent)
                }
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        .onAppear{
            userCredentialsPresenter.view = self
            userCredentialsPresenter.interactor = UserCredentialsInteractorImplementation()
            userCredentialsPresenter.interactor?.output = userCredentialsPresenter as? UserCredentialsPresenterImplementation
            DispatchQueue.main.async {
                userCredentialsPresenter.fetchUserCredentials()
            }
        }
        
    }
}
extension RootView : UserPresenterToView {
    func finishLoading(username: String) {
        withAnimation {
            self.username = username
        }
    }
}

//struct RootView_Previews: PreviewProvider {
//    static var previews: some View {
//        RootView(data:
//                    DoughnutChartData(
//                        dataSets: PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: ""), metadata: ChartMetadata(title: "", subtitle: ""), noDataText: Text("")))
//        .environmentObject(coreDataViewModel())
//    }
//}
