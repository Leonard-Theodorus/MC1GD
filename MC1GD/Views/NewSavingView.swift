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
    @EnvironmentObject var viewModel : coreDataViewModel
    @State var amount : Double = 0.0
    
    var body: some View {
        NavigationView(){
            VStack{
                Spacer()
                HStack{
                    Spacer()
                    Text("Rp")
                        .font(.largeTitle)
                    TextField("", value: $amount, format: .number)
                        .keyboardType(.numberPad)
                        .foregroundColor(Color.primary_gray)
                        .font(.system(size: 52))
                        .fixedSize()
                    Spacer()
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
                        .background(Color.primary_purple)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .cornerRadius(35)
                        .padding()
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

struct NewSavingView_Previews: PreviewProvider {
    static var previews: some View {
        NewSavingView(showSheet: .constant(true), todayDateComponent: .constant(Date()))
    }
}
