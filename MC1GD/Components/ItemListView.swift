//
//  ItemListView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var categoryShow : CategoryShow
    @State var confirmButton : Bool
    @State var showSheet : Bool = false
    @State var selectedDateComponent : Date = Date()
    
    @State var newItemName : String = ""
    @State var newItemPrice : String = ""
    @State var newItemCategory : String = ""
    @State var newItemTag : String = ""
    @State var newItemDesc : String = ""
    @State var itemPriceInDouble : Double = 0
    
    var body: some View {
        List {
            ForEach(viewModel.userItems){ item in
                // MARK: Section Keinginan
                if categoryShow == .keinginan && item.itemTag == "Keinginan" {
                    VStack{
                        HStack(alignment: .top){
                            Image(systemName: item.itemImage!)
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
                                    .padding(.bottom,-5)
                                Text(item.itemTag!)
                                    .font(Font.custom("SF Pro", size: 8))
                                    .padding(8)
                                    .frame(height:15)
                                    .background(item.itemTag! == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                    .foregroundColor(.white)
                                    .textCase(.uppercase)
                                    .cornerRadius(3)
                                Text(item.itemDescription!)
                                    .font(.caption2)
                                    .italic()
                                    .foregroundColor(Color("primary-gray"))
                                    .padding(.top,1)
                                    .lineSpacing(2)
                            }
                            Spacer()
                            Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                .foregroundColor(Color("primary-red"))
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal,-1)
                        .padding(.top)
                        .swipeActions {
                            Button{
                                //TODO: Add view model edit
                                showSheet.toggle()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyyMMdd"
                                if let itemDate = item.itemAddedDate ,let currentItemDate = formatter.date(from: itemDate){
                                    selectedDateComponent = currentItemDate
                                }
                                newItemPrice = String(item.itemPrice)
                                newItemCategory = item.itemCategory!
                                newItemTag = item.itemTag!
                                newItemDesc = item.itemDescription!
                                newItemName = item.itemName!
                                itemPriceInDouble = item.itemPrice
                                
                            } label: {
                                Label("", systemImage: "pencil")
                            }
                            .tint(.yellow)
                            Button{
                                viewModel.deleteItem(for:  item.itemId!)
                            } label: {
                                Label("", systemImage: "trash")
                            }.tint(.red)
                            
                            
                        }
                        .sheet(isPresented: $showSheet) {
                            EditItemView(showSheet: $showSheet, newItemPrice: $newItemPrice, num: $itemPriceInDouble, newItemCategory: $newItemCategory, newItemTag: $newItemTag, newItemDesc: $newItemDesc, newItemName: $newItemName, itemId: item.itemId!, todayDateComponent: $selectedDateComponent)
                            
                        }
                        Rectangle()
                            .foregroundColor(Color.tertiary_gray)
                            .frame(height: 1)
                            .padding(.vertical,2)
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                // MARK: Section Kebutuhan
                else if categoryShow == .kebutuhan && item.itemTag == "Kebutuhan" {
                    VStack{
                        HStack(alignment: .top){
                            Image(systemName: item.itemImage!)
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
                                    .padding(.bottom,-5)
                                Text(item.itemTag!)
                                    .font(Font.custom("SF Pro", size: 8))
                                    .padding(8)
                                    .frame(height:15)
                                    .background(item.itemTag! == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                    .foregroundColor(.white)
                                    .textCase(.uppercase)
                                    .cornerRadius(3)
                                Text(item.itemDescription!)
                                    .font(.caption2)
                                    .italic()
                                    .foregroundColor(Color("primary-gray"))
                                    .padding(.top,1)
                                    .lineSpacing(2)
                            }
                            Spacer()
                            Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                .foregroundColor(Color("primary-red"))
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal,-1)
                        .padding(.top)
                        .swipeActions {
                            Button{
                                //TODO: Add view model edit
                                showSheet.toggle()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyyMMdd"
                                if let itemDate = item.itemAddedDate ,let currentItemDate = formatter.date(from: itemDate){
                                    selectedDateComponent = currentItemDate
                                }
                                newItemPrice = String(item.itemPrice)
                                newItemCategory = item.itemCategory!
                                newItemTag = item.itemTag!
                                newItemDesc = item.itemDescription!
                                newItemName = item.itemName!
                                itemPriceInDouble = item.itemPrice
                            } label: {
                                Label("", systemImage: "pencil")
                            }
                            .tint(.yellow)
                            
                            Button{
                                viewModel.deleteItem(for:  item.itemId!)
                            } label: {
                                Label("", systemImage: "trash")
                            }.tint(.red)
                        }
                        .sheet(isPresented: $showSheet) {
                            EditItemView(showSheet: $showSheet, newItemPrice: $newItemPrice, num: $itemPriceInDouble, newItemCategory: $newItemCategory, newItemTag: $newItemTag, newItemDesc: $newItemDesc, newItemName: $newItemName, itemId: item.itemId!, todayDateComponent: $selectedDateComponent)
                            
                        }
                        Rectangle()
                            .foregroundColor(Color.tertiary_gray)
                            .frame(height: 1)
                            .padding(.vertical,2)
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
                // MARK: Section Semua
                else if categoryShow == .semua {
                    VStack{
                        HStack(alignment: .top){
                            Image(systemName: item.itemImage!)
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
                                    .padding(.bottom,-5)
                                Text(item.itemTag!)
                                //                                                .font(.caption2)
                                    .font(Font.custom("SF Pro", size: 8))
                                    .padding(8)
                                    .frame(height:15)
                                    .background(item.itemTag! == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                    .foregroundColor(.white)
                                    .textCase(.uppercase)
                                    .cornerRadius(3)
                                Text(item.itemDescription!)
                                    .font(.caption2)
                                    .italic()
                                    .foregroundColor(Color("primary-gray"))
                                    .padding(.top,1)
                                    .lineSpacing(2)
                            }
                            Spacer()
                            Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                .foregroundColor(Color("primary-red"))
                                .fontWeight(.bold)
                        }
                        .padding(.horizontal,-1)
                        .padding(.top)
                        .swipeActions {
                            Button{
                                //TODO: Add view model edit
                                showSheet.toggle()
                                let formatter = DateFormatter()
                                formatter.dateFormat = "yyyyMMdd"
                                if let itemDate = item.itemAddedDate ,let currentItemDate = formatter.date(from: itemDate){
                                    selectedDateComponent = currentItemDate
                                }
                                newItemPrice = String(Int(item.itemPrice))
                                newItemCategory = item.itemCategory!
                                newItemTag = item.itemTag!
                                newItemDesc = item.itemDescription!
                                newItemName = item.itemName!
                                itemPriceInDouble = item.itemPrice
                                
                            } label: {
                                Label("", systemImage: "pencil")
                            }
                            .tint(.yellow)
                            
                            Button{
                                confirmButton.toggle()
                            } label: {
                                Label("", systemImage: "trash")
                            }
                            .tint(.red)
                        }
                        .sheet(isPresented: $showSheet) {
                            EditItemView(showSheet: $showSheet, newItemPrice: $newItemPrice, num: $itemPriceInDouble, newItemCategory: $newItemCategory, newItemTag: $newItemTag, newItemDesc: $newItemDesc, newItemName: $newItemName, itemId: item.itemId!, todayDateComponent: $selectedDateComponent)
                            
                        }
                        .alert(isPresented: self.$confirmButton){
                            Alert(
                                title: Text("Apakah kamu yakin?"),
                                message: Text("Kamu tidak bisa mengubahnya lagi nanti"),
                                primaryButton: .destructive(Text("Hapus")) {
                                    viewModel.deleteItem(for: item.itemId!)
                                },
                                secondaryButton: .cancel(
                                    Text("Batal")
                                        .fontWeight(.regular)
                                )
                            )
                        }
                        Rectangle()
                            .foregroundColor(Color.tertiary_gray)
                            .frame(height: 1)
                            .padding(.vertical,2)
                        
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                }
            }
        }
        .listStyle(.plain)
        .clipped()
    }
}

struct ItemListView_Previews: PreviewProvider {
    static var previews: some View {
        ItemListView(categoryShow: .constant(.semua), confirmButton: false)
    }
}
