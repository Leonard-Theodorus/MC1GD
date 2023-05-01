//
//  ExpenseViewTemp.swift
//  MC1GD
//
//  Created by beni garcia on 01/05/23.
//

import SwiftUI

enum CategoryShow : Int{
    case semua = 0
    case keinginan = 1
    case kebutuhan = 2
}

struct ExpenseViewTemp: View {
    @State private var showSheet = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var todayDateComponent : Date
    @State private var stringDate = ""
    @State private var showDatePicker = false
    @State private var categoryShow : CategoryShow = .semua
    @State var allExpense : Double = 0
    
    var body: some View {
        VStack(alignment: .leading){
            HStack(alignment: .center){
                Text("Expense")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AddItemButton(todayDateComponent: $todayDateComponent)
            }
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "sun.min.fill")
                    Text("Hai,")
                        .font(.title2)
                        .fontWeight(.light)
                    Text("Berwang!")
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
                Text("Pengeluaranmu")
                    .fontWeight(.light)
                    .padding(.horizontal)
                Text(currencyFormatter.string(from: NSNumber(value: allExpense)) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .padding(.vertical,8)
            .foregroundColor(.white)
            .background(
                LinearGradient(colors: [Color("secondary-purple"),Color("primary-purple")], startPoint: .topLeading, endPoint: .bottomTrailing))
            .cornerRadius(22)
            VStack{
                HStack{
                    Text("Pengeluaran")
                        .font(.headline)
                        .foregroundColor(Color("primary-gray"))
                    Spacer()
                    Button{
                        withAnimation {
                            showDatePicker.toggle()
                        }
                    } label: {
                        Text(Date().formatDateFrom(for: todayDateComponent))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray)
                            )
                    }
                    .background(
                        DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .clipped()
                            .background(Color.gray.cornerRadius(10))
                            .opacity(showDatePicker ? 1 : 0)
                            .offset(y: 50)
                            .onChange(of: todayDateComponent, perform: { newValue in
                                DispatchQueue.main.async {
                                    withAnimation {
                                        showDatePicker.toggle()
                                        viewModel.fetchItems(for: todayDateComponent)
                                    }
                                }
                                
                            })
                    )
                }
                .padding(.horizontal,8)
                Picker("Category", selection: $categoryShow){
                    Text("Semua").tag(CategoryShow.semua)
                    Text("Keinginan").tag(CategoryShow.keinginan)
                    Text("Kebutuhan").tag(CategoryShow.kebutuhan)
                }
                .pickerStyle(.segmented)
                ForEach(viewModel.userItems){ item in
                    if categoryShow == .keinginan && item.itemTag == "Keinginan" {
                        VStack{
                            HStack(alignment: .top){
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .padding(12)
                                    .scaledToFit()
                                    .frame(width: 54,height: 54)
                                    .background(Color("primary-purple"))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                VStack(alignment: .leading){
                                    Text(item.itemName!)
                                        .font(.headline)
                                    Text(item.itemTag!)
                                        .font(.caption)
                                        .padding(.horizontal,5)
                                        .background(Color("primary-orange"))
                                        .foregroundColor(.white)
                                        .cornerRadius(3)
                                    Text(item.itemDescription!)
                                        .font(.caption2)
                                        .foregroundColor(Color("primary-gray"))
                                        .padding(.top,1)
                                        .lineSpacing(4)
                                }
                                Spacer()
                                Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                    .foregroundColor(Color("primary-red"))
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal,-1)
                            .padding(.top)
                            Rectangle()
                                .foregroundColor(Color("primary-gray"))
                                .frame(height: 1)
                                .padding(.vertical,2)
                        }
                    }else if categoryShow == .kebutuhan && item.itemTag == "Kebutuhan" {
                        VStack{
                            HStack(alignment: .top){
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .padding(12)
                                    .scaledToFit()
                                    .frame(width: 54,height: 54)
                                    .background(Color("primary-purple"))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                VStack(alignment: .leading){
                                    Text(item.itemName!)
                                        .font(.headline)
                                    Text(item.itemTag!)
                                        .font(.caption)
                                        .padding(.horizontal,5)
                                        .background(Color("primary-orange"))
                                        .foregroundColor(.white)
                                        .cornerRadius(3)
                                    Text(item.itemDescription!)
                                        .font(.caption2)
                                        .foregroundColor(Color("primary-gray"))
                                        .padding(.top,1)
                                        .lineSpacing(4)
                                }
                                Spacer()
                                Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                    .foregroundColor(Color("primary-red"))
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal,-1)
                            .padding(.top)
                            Rectangle()
                                .foregroundColor(Color("primary-gray"))
                                .frame(height: 1)
                                .padding(.vertical,2)
                        }
                    }else if categoryShow == .semua {
                        VStack{
                            HStack(alignment: .top){
                                Image(systemName: "fork.knife")
                                    .resizable()
                                    .padding(12)
                                    .scaledToFit()
                                    .frame(width: 54,height: 54)
                                    .background(Color("primary-purple"))
                                    .cornerRadius(10)
                                    .foregroundColor(.white)
                                VStack(alignment: .leading){
                                    Text(item.itemName!)
                                        .font(.headline)
                                    Text(item.itemTag!)
                                        .font(.caption)
                                        .padding(.horizontal,5)
                                        .background(Color("primary-orange"))
                                        .foregroundColor(.white)
                                        .cornerRadius(3)
                                    Text(item.itemDescription!)
                                        .font(.caption2)
                                        .foregroundColor(Color("primary-gray"))
                                        .padding(.top,1)
                                        .lineSpacing(4)
                                }
                                Spacer()
                                Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                    .foregroundColor(Color("primary-red"))
                                    .fontWeight(.bold)
                            }
                            .padding(.horizontal,-1)
                            .padding(.top)
                            Rectangle()
                                .foregroundColor(Color("primary-gray"))
                                .frame(height: 1)
                                .padding(.vertical,2)
                        }
                    }
                }
                
                
                
                Spacer()
            }
            .padding()
            .background(.white)
            .cornerRadius(35)
            .clipped()
            .shadow(color: Color.gray, radius: 4, x: -2, y: 2)
            .padding(.top,12)
        }
        .padding(.horizontal,22)
    }
}

struct ExpenseViewTemp_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseViewTemp(todayDateComponent: .constant(Date()))
            .environmentObject(coreDataViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
            
    }
}