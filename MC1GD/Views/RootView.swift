//
//  RootView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct RootView: View {
    
    @State var selectedTab : Tabs = .summary
    
    var body: some View {
        
        VStack{
            if selectedTab == .summary {
                SummaryView()
            }else if selectedTab == .expense {
                ExpenseView()
            }
            
            Spacer()
            
            CustomTabBar(selectedTab: $selectedTab)
        }
        
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
