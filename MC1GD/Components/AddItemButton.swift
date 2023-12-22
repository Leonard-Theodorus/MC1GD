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
        .controlSize(.large)
        .sheet(isPresented: $showSheet) {
            NewItemView(edit: .constant(false), showSheet: $showSheet, todayDateComponent: $todayDateComponent)
        }
    }
}

struct AddItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButton(showSheet: false, todayDateComponent: .constant(Date()))
    }
}
