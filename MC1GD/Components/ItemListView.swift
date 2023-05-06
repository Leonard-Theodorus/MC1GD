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
                                viewModel.deleteItem(for:  item.itemId!)
                            } label: {
                                Label("", systemImage: "trash")
                            }.tint(.red)
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
                                viewModel.deleteItem(for:  item.itemId!)
                            } label: {
                                Label("", systemImage: "trash")
                            }.tint(.red)
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
                                viewModel.deleteItem(for:  item.itemId!)
                            } label: {
                                Label("", systemImage: "trash")
                            }.tint(.red)
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
        ItemListView(categoryShow: .constant(.semua))
    }
}
