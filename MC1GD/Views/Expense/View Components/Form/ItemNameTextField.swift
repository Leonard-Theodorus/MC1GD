//
//  itemNameTextField.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct ItemNameTextField: View {
    @Binding var expenseName : String
    @Binding var inputValid : Bool
    
    var body: some View {
        Text("Aa")
            .font(.headline)
            .foregroundColor(Color.primary_gray)
            .padding(.horizontal,15)
        
        TextField("Nama Barang", text: $expenseName)
            .autocorrectionDisabled(true)
            .overlay(alignment: .trailing){
                if inputValid{
                    ZStack{
                        Button {
                            withAnimation {
                                expenseName = ""
                                inputValid = false
                            }
                        } label: {
                            Image(systemName: "delete.left").foregroundColor(.red)
                        }
                        .buttonStyle(.borderless)
                        .clipped()
                        
                    }
                }
                else{
                    EmptyView()
                }
            }
            .onChange(of: expenseName){ newExpenseName in
                if newExpenseName.count != 0 && newExpenseName.first != " " && newExpenseName.last != " "{
                    withAnimation {
                        inputValid = true
                    }
                    
                }
                else{
                    withAnimation {
                        inputValid = false
                    }
                }
            }
    }
}

//struct itemNameTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        ItemNameTextField(formVm: FormViewModel())
//    }
//}
