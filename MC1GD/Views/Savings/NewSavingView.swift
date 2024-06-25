//
//  NewSavingView.swift
//  MC1GD
//
//  Created by beni garcia on 04/05/23.
//

import SwiftUI
struct NewSavingView: View {
    
    @Binding var showSheet : Bool
    @Binding var todayDateComponent : Date
    @State var amount : Double = 0.0
    @State var newSavingsAmount : String = ""
    @State var priceValid: Bool = false
    @FocusState var isFocusedPrice : Bool
    @State var confirmButton : Bool = false
    @Binding var presenter : SavingsListPresenter
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                VStack {
                    Group {
                        HStack{
                            Spacer()
                            Text("Rp")
                                .font(.largeTitle)
                            TextField("0", text: $newSavingsAmount)
                                .keyboardType(.numberPad)
                                .foregroundColor(Color.primary_gray)
                                .font(.system(size: 52))
                                .fixedSize()
                                .focused($isFocusedPrice)
                                .onChange(of: newSavingsAmount) { newValue in
                                    withAnimation {
                                        let numberString = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                                        if let number = Double(numberString) {
                                            amount = number
                                            newSavingsAmount = currencyFormatterInForm.string(from: NSNumber(value: amount)) ?? ""
                                        }
                                        if (numberString != "0" && numberString != ""){
                                            priceValid = true
                                        }
                                        else{
                                            priceValid = false
                                        }
                                    }
                                    
                                }
                            Spacer()
                            Button {
                                withAnimation {
                                    newSavingsAmount = ""
                                }
                            } label: {
                                Image(systemName: "delete.left").foregroundColor(.red)
                            }
                            .buttonStyle(.borderless)
                            .clipped()
                            .opacity(priceValid ? 1.0 : 0.0)
                            .padding(.trailing,30)
                        }
                    }
                    if !priceValid && isFocusedPrice == true{
                        Text("Harga tidak boleh 0")
                            .foregroundColor(.red)
                            .font(.caption2)
                            .multilineTextAlignment(.leading)
                            .padding(.leading,60)
                    }
                    else if priceValid && isFocusedPrice == true {
                        Image(systemName: "checkmark").foregroundColor(.green)
                            .padding(.horizontal,15)
                    }
                }
                Spacer()
                Button{
                    confirmButton.toggle()
                }label: {
                    Text("+ Tambah")
                        .foregroundColor(Color.white)
                        .padding(.horizontal,120)
                        .padding(.vertical,24)
                        .background(amount == 0 ? Color.secondary_gray : Color.primary_purple)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .cornerRadius(35)
                        .padding()
                }
                .disabled(amount == 0)
                .alert(isPresented: self.$confirmButton){
                    Alert(
                        title: Text("Apakah kamu yakin?"),
                        message: Text("Kamu tidak bisa mengubahnya lagi nanti"),
                        primaryButton: .default(Text("Tambah").foregroundColor(.blue).fontWeight(.bold)) {
                            //TODO: Write Savings
                            let newSavingData = UserSaving(savingAmount: amount, dateAdded: todayDateComponent)
                            presenter.writeSavings(savingData: newSavingData)
                            showSheet = false
                        },
                        secondaryButton: .cancel(
                            Text("Batal")
                                .fontWeight(.regular)
                        )
                    )
                }
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Kembali"){
                        showSheet.toggle()
                    }
                    .foregroundColor(Color.primary_purple)
                }
                ToolbarItem(placement: .principal) {
                    Text("Tambah Tabungan").font(.title3)
                }
            }
        }
    }
}

//struct NewSavingView_Previews: PreviewProvider {
//    static var previews: some View {
//        NewSavingView(showSheet: .constant(true), todayDateComponent: .constant(Date()))
//    }
//}
