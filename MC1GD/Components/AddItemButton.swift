//
//  AddItemButton.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import SwiftUI
struct AddItemButton: View {
    @State var showSheet = false
    @Binding var todayDateComponent : Date
    var body: some View {
        Button {
            showSheet.toggle()
        }label: {
            Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(Color("primary-purple"))
        }
        .padding()
        .controlSize(.large)
        .sheet(isPresented: $showSheet) {
            NewItemView(showSheet: $showSheet, todayDateComponent: $todayDateComponent)
//                .background(Color("primary-white"))
        }
    }
}

struct AddItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButton(showSheet: false, todayDateComponent: .constant(Date()))
    }
}
