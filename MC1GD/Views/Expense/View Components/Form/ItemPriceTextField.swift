//
//  ItemPriceTextField.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct ItemPriceTextField: View {
    @Binding var newItemPrice : String
    @Binding var num : Double
    @Binding var priceValid : Bool
    var body: some View {
        Group {
            Text("Rp")
                .font(.caption)
                .fontWeight(.semibold)
                .padding(.horizontal,10)
                .padding(.vertical,6)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray)
                        .background(Color("tertiary-gray").cornerRadius(10)))
                .foregroundColor(Color("primary-gray"))
                .frame(width: 40)
            Divider().frame(height: 30)
            TextField("Harga Barang", text: $newItemPrice)
                .disableAutocorrection(true)
                .lineLimit(0)
                .keyboardType(.numberPad)
                .font(.title2)
            
                .onChange(of: newItemPrice) { newValue in
                    withAnimation {
                        let numberString = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                        if let number = Double(numberString) {
                            num = number
                            newItemPrice = currencyFormatterInForm.string(from: NSNumber(value: num)) ?? ""
                        }
                        if (numberString != "0" && numberString != ""){
                            priceValid = true
                        }
                        else{
                            priceValid = false
                        }
                    }
                    
                }
                .overlay (
                    ZStack{
                        Button {
                            withAnimation {
                                newItemPrice = ""
                            }
                        } label: {
                            Image(systemName: "delete.left").foregroundColor(.red)
                        }
                        .buttonStyle(.borderless)
                        .clipped()
                        .opacity(priceValid ? 1.0 : 0.0)
                        
                    }
                    , alignment: .trailing
                )
        }
    }
}

struct ItemPriceTextField_Previews: PreviewProvider {
    static var previews: some View {
        ItemPriceTextField(newItemPrice: .constant(""), num: .constant(0), priceValid: .constant(false))
    }
}
