//
//  EditItemView.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 22/12/23.
//

import SwiftUI
import Combine

struct EditItemView: View {
    
    @FocusState private var focusedField: Field?
    @FocusState var isFocusedName : Bool
    @FocusState var isFocusedPrice : Bool
    @FocusState var isFocusedDesc : Bool

    @Binding var showSheet : Bool
    
    @Binding var num : Double
    
    @Binding var newItemDesc : String

    @Binding var presenter : ExpenseListPresenter
    
    @State var inputValid : Bool = true
    @State var isNeeds : Bool = false
    @State var isWants : Bool = false
    @State private var maxChars: Int = 50
    @State var isZeroPrice: Bool = false
    @State var showQuestions = false
    @State var showDatePicker : Bool = false
    @State var showDeleteIcon : Bool = false
    @State var priceValid : Bool = true
    
    @State var updatedExpense : UserExpense
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                ScrollView {
                    VStack(alignment: .leading){
                        // MARK: harga barang
                        Group{
                            HStack{
                                ItemPriceTextField(newItemPrice: Binding(
                                    get: {
                                        updatedExpense.expensePrice
                                    },
                                    set: { newExpense in
                                        updatedExpense.expensePrice = newExpense
                                    }),num: $num, priceValid: $priceValid)
                                .focused($focusedField, equals: Field.itemPrice)
                                .onTapGesture {
                                    focusedField = Field.itemPrice
                                }
                            }
                            .padding(.bottom, 5)
                            if !priceValid && focusedField == .itemPrice{
                                Text("Harga tidak boleh 0")
                                    .foregroundColor(.red)
                                    .font(.caption2)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading,60)
                            }
                            else if priceValid && focusedField == .itemPrice {
                                Image(systemName: "checkmark").foregroundColor(.green)
                                    .padding(.horizontal,15)
                            }
                            
                        }
                        Divider()
                        
                        // MARK: Nama Barang
                        Group{
                            HStack {
                                //TODO: Benerin FORM VM (Mungkin refactor jadi plain SwiftUI
                                ItemNameTextField(expenseName : Binding(
                                    get: {
                                        updatedExpense.expenseName
                                    }, set: { newExpenseName in
                                        updatedExpense.expenseName = newExpenseName
                                    }), inputValid: $inputValid)
                                    .focused($focusedField, equals: Field.itemName)
                                    .onTapGesture {
                                        focusedField = Field.itemName
                                    }
                            }.padding(.vertical, 5)
                            if !inputValid && focusedField == .itemName{
                                Text("Harus diisi, tidak diawali ataupun diakhiri dengan spasi")
                                    .foregroundColor(.red)
                                    .font(.caption2)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading,60)
                            }else if inputValid && focusedField == .itemName {
                                Image(systemName: "checkmark").foregroundColor(.green)
                                    .padding(.horizontal,15)
                            }
                        }
                        Divider()
                        
                        
                        // MARK: pilih itemCategory
                        Group {
                            ExpenseCategoryPicker(newItemCategory: Binding(
                                get: {
                                    guard let editingExpenseCategory = ExpenseCategory(rawValue: updatedExpense.expenseCategory)
                                    else { return .fnb}
                                    return editingExpenseCategory
                                },
                                set: { newCategory in
                                    switch newCategory{
                                        case .fnb:
                                            updatedExpense.imageString = "fork.knife"
                                        case .transport:
                                            updatedExpense.imageString = "tram.fill"
                                        case .item:
                                            updatedExpense.imageString = "bag"
                                            
                                    }
                                    updatedExpense.expenseCategory = newCategory.rawValue
                                }
                            ))
                        }
                        // MARK:  pilih itemTag needs/wants
                        Group {
                            ItemTagField(
                                isNeeds: $isNeeds,
                                isWants: $isWants,
                                showQuestions: $showQuestions,
                                newItemTag: Binding(
                                    get: {
                                        updatedExpense.expenseTag
                                    }, set: { newTag in
                                        updatedExpense.expenseTag = newTag
                                    }))
                        }
                        // MARK:  input deskripsi item
                        Group {
                            VStack {
                                HStack(alignment: .top){
                                    Image(systemName: "text.alignleft")
                                        .imageScale(.large)
                                        .foregroundColor(Color.primary_gray)
                                        .padding(.horizontal,15)
                                    TextField(
                                        "Deskripsi (50 Karakter)",
                                        text: Binding(
                                            get: {
                                                updatedExpense.expenseDescription
                                            }, set: { newDesc in
                                                updatedExpense.expenseDescription = newDesc
                                            }),
                                        axis: .vertical
                                    )
                                        .focused($isFocusedDesc)
                                        .lineLimit(5, reservesSpace: true)
                                        .disableAutocorrection(true)
                                        .textFieldStyle(.roundedBorder)
                                        .font(.body)
                                        .fontWeight(.thin)
                                        .onChange(of: newItemDesc) {newValue in
                                            if newValue.count >= maxChars {
                                                newItemDesc = String(newValue.prefix(maxChars))
                                            }
                                        }
                                }
                                HStack{
                                    Spacer()
                                    Text("\($newItemDesc.wrappedValue.count)/50")
                                        .font(.caption)
                                        .foregroundColor($newItemDesc.wrappedValue.count == maxChars ? .red : .gray)
                                }
                            }.padding(.top, 10)
                            Divider()
                        }
                        
                        
                        // MARK: select tanggal
                        Group{
                            DatePickerFormField(
                                showDatePicker: $showDatePicker,
                                todayDateComponent: Binding(
                                    get: {
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyyMMdd"
                                        let expenseDate = formatter.date(from: updatedExpense.expenseDate)
                                        return expenseDate!
                                    }, set: { newDate  in
                                        updatedExpense.expenseDate = newDate.formatExpenseDate(for: newDate)
                                    })
                            )
                        }
                    }
                    .padding(.horizontal,20)
                    .padding(.bottom, 30)
                    .onTapGesture{
                        focusedField = nil
                    }
                    
                    Spacer()
                }
            }
            .onAppear{
                let currencyCodeIndex = updatedExpense.expensePrice.index(
                    updatedExpense.expensePrice.startIndex, offsetBy: 2)
                updatedExpense.expensePrice = String(updatedExpense.expensePrice[currencyCodeIndex...])

                if updatedExpense.expenseTag == "Kebutuhan"{
                    isNeeds.toggle()
                }
                else{
                    isWants.toggle()
                }
                
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Kembali"){
                        showSheet.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Sunting Pengeluaran").font(.headline)
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Simpan"){
                        presenter.editExpense(expense: updatedExpense)
                        let formatter = DateFormatter()
                        formatter.dateFormat = "yyyyMMdd"
                        dateNotif.send(formatter.date(from: updatedExpense.expenseDate)!)
                        showSheet = false
                    }
                    .disabled(!inputValid || !priceValid || updatedExpense.expenseTag == "")
                }
            }
        }
    }
}

//#Preview {
//    EditItemView()
//}
