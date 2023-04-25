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
        Button("Add Item") {
            showSheet.toggle()
        }
        .controlSize(.large)
        .tint(LinearGradient(gradient: Gradient(colors: [.green, .white]), startPoint: .leading, endPoint: .trailing))
        .buttonStyle(.borderedProminent)
        .sheet(isPresented: $showSheet) {
            NewItemView(showSheet: $showSheet)
        }.onDisappear{
            
        }
    }
}

struct AddItemButton_Previews: PreviewProvider {
    static var previews: some View {
        AddItemButton(showSheet: false)
    }
}
