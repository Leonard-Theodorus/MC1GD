//
//  RootView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab : Tabs = .expense
    @State private var todayDateComponent = Date()
    @EnvironmentObject var viewModel: coreDataViewModel
    
    var body: some View {
        VStack{
            if(viewModel.checkEmptyUsername()){
                WelcomeScreen()
                    .onAppear{
                        viewModel.fetchUser()
                    }
            }else{
                if selectedTab == .summary {
                    SummaryView(todayDateComponent: $todayDateComponent)
                }else if selectedTab == .expense {
    //                ExpenseView(todayDateComponent: $todayDateComponent)
                    ExpenseViewTemp(todayDateComponent: $todayDateComponent)
                }
                Spacer()
                
                CustomTabBar(selectedTab: $selectedTab)
            }
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
            .environmentObject(coreDataViewModel())
    }
}
