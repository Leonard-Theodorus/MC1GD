//
//  SavingsView.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 04/05/23.
//

import SwiftUI

struct SavingsView: View {
    @State private var showSheet = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var todayDateComponent : Date
    @State private var stringDate = ""
    @State private var showDatePicker = false
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: title & addItemButton
            HStack(alignment: .center){
                Text("Tabungan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AddSavingButton(todayDateComponent: $todayDateComponent)
            }
            .onAppear(){
                viewModel.fetchSaving()
            }
            // MARK: Hello Card
            VStack(alignment: .leading){
                HStack{
                    Image("rp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Total Tabunganmu")
                        .font(.title3)
                        .fontWeight(.light)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                Text(currencyFormatter.string(from: NSNumber(value: viewModel.getUserMoney())) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom,5)
                if viewModel.getUserMoneyToday() == 0 {
                    Text("Ayo semangat menabung!")
                        .font(.body)
                        .fontWeight(.light)
                        .italic()
                        .padding(.horizontal)
                        .padding(.bottom)
                }else{
                    Text(currencyFormatter.string(from: NSNumber(value: viewModel.getUserMoneyToday())) ?? "")
                        .fontWeight(.light)
                        .padding(.horizontal)
                        .padding(.bottom)
                }
                
            }
            .padding(.vertical,8)
            .foregroundColor(.white)
            .background(
                ZStack{
                    LinearGradient(colors: [Color("secondary-purple"),Color("primary-purple")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Image("beruang-welcome")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        }
                        .padding(.trailing)
                        
                    }
                }
                
            )
            .cornerRadius(22)
            
            // MARK: Tabungan History Card
            if !viewModel.savingList.isEmpty{
                List{
                    ForEach(viewModel.savingList.suffix(10).reversed()) { saving in
                        VStack{
                            HStack(alignment: .top){
                                VStack(alignment: .leading){
                                    Text(viewModel.getSavingDate(date: saving.savingDate!))
                                        .font(.headline)
                                        .padding(.bottom,-5)
                                }
                                Spacer()
                                Text("+ \(currencyFormatter.string(from: NSNumber(value: saving.savingAmount)) ?? "")")
                                    .foregroundColor(Color.primary_green)
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal,3)
                            .padding(.vertical)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                }
                .padding()
                .padding(.top,3)
                .background(.white)
                .cornerRadius(22)
                .onAppear(){
                    viewModel.fetchSaving()
                }
                .listStyle(.plain)
                .clipped()
                .shadow(color: Color.gray, radius: 4, y: 2)
                .padding(.top)
            }else {
                EmptyData(desc: "Belum ada tabungan")
                    .foregroundColor(Color.secondary_gray)
                    .padding()
                    .padding(.top,3)
                    .background(.white)
                    .cornerRadius(22)
                    .padding(.top)
                    .shadow(color: Color.gray, radius: 4, y: 2)
            }
            
            
            
        }
        .padding(.horizontal,22)
        
        
    }
}

struct SavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsView(todayDateComponent: .constant(Date()))
            .environmentObject(coreDataViewModel())
    }
}
