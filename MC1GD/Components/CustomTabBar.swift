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
                TabBarButton(buttonText: "Pengeluaran", imageName: "creditcard.circle", isActive: selectedTab == .expense)
            }
            .tint(.white)
            
            Rectangle()
                .foregroundColor(.white)
                
                .frame(width: 0.5)
                .padding(.top,10)
            
            Button{
                selectedTab = .summary
            }label: {
                TabBarButton(buttonText: "Ringkasan", imageName: "list.bullet.clipboard.fill", isActive: selectedTab == .summary)
                
            }
            .tint(.white)
            
            Rectangle()
                .foregroundColor(.white)
                
                .frame(width: 0.5)
                .padding(.top,10)
            
            Button{
                selectedTab = .tabungan
            }label: {
                TabBarButton(buttonText: "Tabungan", imageName: "dollarsign.circle.fill", isActive: selectedTab == .tabungan)
                
            }
            .tint(.white)
        }
        .frame(height: 90)
        .background(Color("primary-purple"))
    }
    
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.summary))
    }
}
