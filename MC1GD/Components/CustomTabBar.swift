//
//  CustomTabBar.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

enum Tabs: Int{
    case summary = 0
    case expense = 1
}

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .center){
            
            Button{
                selectedTab = .summary
            }label: {
                TabBarButton(buttonText: "Summary", imageName: "book.fill", isActive: selectedTab == .summary)
            }
            .tint(Color("tab-bar-color"))
            
            Button{
                selectedTab = .expense
            }label: {
                TabBarButton(buttonText: "Expense", imageName: "wallet.pass", isActive: selectedTab == .expense)
            }
            .tint(Color("tab-bar-color"))
        }
        .frame(height: 120)
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.summary))
    }
}
