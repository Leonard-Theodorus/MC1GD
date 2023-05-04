//
//  CustomTabBar.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct CustomTabBar: View {
    
    @Binding var selectedTab: Tabs
    
    var body: some View {
        HStack(alignment: .center){
            
            Button{
                selectedTab = .expense
            }label: {
                TabBarButton(buttonText: "Pengeluaran", imageName: "creditcard.fill", isActive: selectedTab == .expense)
            }
            
            Button{
                selectedTab = .summary
            }label: {
                TabBarButton(buttonText: "Ringkasan", imageName: "list.bullet.clipboard.fill", isActive: selectedTab == .summary)
                
            }
            
            Button{
                selectedTab = .tabungan
            }label: {
                TabBarButton(buttonText: "Tabungan", imageName: "rupiah", isActive: selectedTab == .tabungan)
                
            }
        }
        .frame(height: 58)
        .background(Color.primary_white)
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.summary))
    }
}
