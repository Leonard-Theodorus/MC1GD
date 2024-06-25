//
//  AddSavingButton.swift
//  MC1GD
//
//  Created by beni garcia on 04/05/23.
//

import SwiftUI

struct AddSavingButton: View {
    @State var showSheet = false
    @Binding var todayDateComponent: Date
    @Binding var presenter : SavingsListPresenter
    
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
                NewSavingView(showSheet: $showSheet, todayDateComponent: $todayDateComponent, presenter: $presenter)
            }
        
    }
}

//struct AddSavingButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AddSavingButton(showSheet: false, todayDateComponent: .constant(Date()))
//    }
//}
