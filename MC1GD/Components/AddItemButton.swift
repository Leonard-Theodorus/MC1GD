//
//  AddItemButton.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import SwiftUI
struct AddItemButton: View {
    @State var showSheet = false
    var body: some View {
        Button {
            showSheet.toggle()
        }label: {
            Image(systemName: "plus")
            .imageScale(.large)
            .foregroundColor(Color("main-purple"))
        }
        .padding()
        .controlSize(.large)
        .sheet(isPresented: $showSheet) {
            NewItemView(showSheet: $showSheet)
        }
    }
}

struct AddItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButton(showSheet: false)
    }
}
