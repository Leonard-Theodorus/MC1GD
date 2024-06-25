//
//  ItemListView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct ItemListView: View {
    @Binding var expenses : [UserExpense]
    @Binding var presenter : ExpenseListPresenter
    
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
            ForEach(expenses){ expense in
                VStack{
                    HStack(alignment: .top){
                        Image(systemName: expense.imageString)
                            .resizable()
                            .padding(12)
                            .scaledToFit()
                            .frame(width: 54,height: 54)
                            .background(Color("primary-purple"))
                            .cornerRadius(10)
                            .foregroundColor(.white)
                        VStack(alignment: .leading){
                            Text(expense.expenseName)
                                .font(.headline)
                                .padding(.bottom,-5)
                            Text(expense.expenseTag)
                                .font(Font.custom("SF Pro", size: 8))
                                .padding(8)
                                .frame(height:15)
                                .background(expense.expenseTag == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                .foregroundColor(.white)
                                .textCase(.uppercase)
                                .cornerRadius(3)
                            Text(expense.expenseDescription)
                                .font(.caption2)
                                .italic()
                                .foregroundColor(Color("primary-gray"))
                                .padding(.top,1)
                                .lineSpacing(2)
                        }
                        Spacer()
                        Text("- \(expense.expensePrice)")
                            .foregroundColor(Color("primary-red"))
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal,-1)
                    .padding(.top)
                    .swipeActions {
                        Button{
                            //TODO: Add view model edit
                            showSheet.toggle()
                        } label: {
                            Label("", systemImage: "pencil")
                        }
                        .tint(.yellow)
                        Button{
                            presenter.deleteExpense(expenseId: expense.id, date: expense.expenseDate)
                        } label: {
                            Label("", systemImage: "trash")
                        }.tint(.red)
                        
                        
                    }
                    .sheet(isPresented: $showSheet) {
                        EditItemView(
                            showSheet: $showSheet,
                            num: $itemPriceInDouble,
                            newItemDesc: $newItemDesc,
                            presenter: $presenter,
                            updatedExpense: expense)
                        
                        
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
        .listStyle(.plain)
        .scrollIndicators(.hidden)
        .clipped()
    }
}

