//
//  itemNameTextField.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct itemNameTextField: View {
    @StateObject var formVm : addItemFormViewModel
    var body: some View {
        Text("Aa")
            .font(.headline)
            .foregroundColor(Color.primary_gray)
            .padding(.horizontal,15)
        TextField("Nama Barang", text: $formVm.itemName).autocorrectionDisabled(true)
            .overlay (
                ZStack{
                    Button {
                        withAnimation {
                            formVm.deleteText()
                        }
                    } label: {
                        Image(systemName: "delete.left").foregroundColor(.red)
                    }
                    .buttonStyle(.borderless)
                    .clipped()
                    .opacity(formVm.buttonDeleteOn ? 1.0 : 0.0)
                    
                }
                , alignment: .trailing
            )
    }
}

struct itemNameTextField_Previews: PreviewProvider {
    static var previews: some View {
        itemNameTextField(formVm: addItemFormViewModel())
    }
}
