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
    @State var allSavings : Double = 0
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: title & addItemButton
            HStack(alignment: .center){
                Text("Tabungan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AddItemButton(todayDateComponent: $todayDateComponent)
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
                Text(currencyFormatter.string(from: NSNumber(value: allSavings)) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom,5)
                if allSavings == 0 {
                    Text("Ayo semangat menabung!")
                        .font(.body)
                        .fontWeight(.light)
                        .italic()
                        .padding(.horizontal)
                        .padding(.bottom)
                }else{
                    Text("Ayo semangat menabung!")
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
            VStack{
                VStack{
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text("3 Mei 2023")
                                .font(.headline)
                                .padding(.bottom,-5)
                            Text("Sisa Uang Jajan")
                                .font(.caption2)
                                .italic()
                                .foregroundColor(Color("primary-gray"))
                                .padding(.top,1)
                                .lineSpacing(2)
                        }
                        Spacer()
                        Text("+ \(currencyFormatter.string(from: NSNumber(value: 0)) ?? "")")
                            .foregroundColor(Color.primary_green)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal,-1)
                    .padding(.top)
                    
                    Rectangle()
                        .foregroundColor(Color.tertiary_gray)
                        .frame(height: 1)
                        .padding(.vertical,2)
                    
                }
            }
            .padding()
            .background(.white)
            .cornerRadius(22)
            .shadow(color: Color.gray, radius: 4, y: 2)
            .padding(.top,12)
            //            .onTapGesture {showDatePicker = false}
            
        }
        .padding(.horizontal,22)
        
        
    }
}

struct SavingsView_Previews: PreviewProvider {
    static var previews: some View {
        SavingsView(todayDateComponent: .constant(Date()))
    }
}
