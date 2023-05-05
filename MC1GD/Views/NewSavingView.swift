//
//  NewSavingView.swift
//  MC1GD
//
//  Created by beni garcia on 04/05/23.
//

import SwiftUI
import Combine
struct NewSavingView: View {
    @Binding var showSheet : Bool
    @Binding var todayDateComponent : Date
    @EnvironmentObject var viewModel : coreDataViewModel
    @State var amount : Double = 0.0
    @State var isZeroPrice: Bool = false
    @State var showDeleteIcon : Bool = false
    @FocusState var isFocusedPrice : Bool
    
    var body: some View {
        NavigationView{
            VStack{
                Spacer()
                VStack {
                    HStack{
                        Spacer()
                        Text("Rp")
                            .font(.largeTitle)
                        TextField("", value: $amount, format: .number)
                            .keyboardType(.numberPad)
                            .foregroundColor(Color.primary_gray)
                            .font(.system(size: 52))
                            .fixedSize()
                            .focused($isFocusedPrice)
                            .onReceive(Just(amount)){ newValue in
                                isZeroPrice = isFocusedPrice && newValue <= 0
                            }
                            .onChange(of: isFocusedPrice){ newValue in
                                if !newValue{
                                    isZeroPrice = amount <= 0
                                }
                            }
                        Spacer()
                        if isZeroPrice == false && isFocusedPrice == true{
                            Button{
                                amount = 0
                                showDeleteIcon.toggle()
                            }label: {
                                HStack(){
                                    Image(systemName: "x.circle.fill")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.primary_red)
                                        
                                }
                            }
                        }
                    }
                    if isZeroPrice {
                        Text("Harga tidak boleh 0")
                            .foregroundColor(Color.primary_red).font(.caption)
                    }
//                    else if isZeroPrice == false && isFocusedPrice == true{
//                        Button{
//                            amount = 0
//                            showDeleteIcon.toggle()
//                        }label: {
//                            HStack{
//                                Spacer()
//                                Image(systemName: "x.circle.fill")
//                                    .resizable()
//                                    .frame(width: 50, height: 50)
//                                    .foregroundColor(.primary_red)
//
//                            }.padding(.bottom, 30)
//                                .background(
//                                    Color.red
//                                )
//                        }
//                    }
                }
                Spacer()
                Button{
                    viewModel.addSaving(money: amount, date: todayDateComponent)
                    showSheet = false
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

struct NewSavingView_Previews: PreviewProvider {
    static var previews: some View {
        NewSavingView(showSheet: .constant(true), todayDateComponent: .constant(Date()))
    }
}
