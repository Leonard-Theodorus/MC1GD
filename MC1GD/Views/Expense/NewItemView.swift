//
//  NewItemView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import SwiftUI
import Combine

let dateNotif = PassthroughSubject<Date, Never>()

struct NewItemView: View {
    
    @Binding var edit : Bool
    @Binding var showSheet : Bool
    @Binding var newItemAddedDate : Date
    @Binding var presenter : ExpenseListPresenter
    
    @State var inputValid : Bool = false
    @State var newItemName : String = ""
    @State var newItemImage = UIImage()
    @State var newItemPrice = ""
    @State var newItemCategory : ExpenseCategory = .fnb
    @State var newItemTag : String = ""
    @State var newItemDesc : String = ""
    @State var isNeeds = false
    @State var isWants = false
    @State private var maxChars: Int = 50
    @State var isZeroPrice: Bool = false
    @State var showQuestions = false
    @State var showDatePicker : Bool = false
    @State var showDeleteIcon : Bool = false
    @State var priceValid : Bool = false
    @State var num : Double = 0
    
    
    @FocusState private var focusedField: Field?
    @FocusState var isFocusedName : Bool
    @FocusState var isFocusedPrice : Bool
    @FocusState var isFocusedDesc : Bool
    
    
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                ScrollView {
                    VStack(alignment: .leading){
                        // MARK: harga barang
                        Group{
                            HStack{
                                ItemPriceTextField(newItemPrice: $newItemPrice, num: $num, priceValid: $priceValid)
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
                                ItemNameTextField(expenseName: $newItemName, inputValid: $inputValid)
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
                            ExpenseCategoryPicker(newItemCategory: $newItemCategory)
                        }
                        // MARK:  pilih itemTag needs/wants
                        Group {
                            ItemTagField(isNeeds: $isNeeds, isWants: $isWants, showQuestions: $showQuestions, newItemTag: $newItemTag)
                        }
                        // MARK:  input deskripsi item
                        Group {
                            VStack {
                                HStack(alignment: .top){
                                    Image(systemName: "text.alignleft")
                                        .imageScale(.large)
                                        .foregroundColor(Color.primary_gray)
                                        .padding(.horizontal,15)
                                    TextField("Deskripsi (50 Karakter)", text: $newItemDesc, axis: .vertical)
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
                            DatePickerFormField(showDatePicker: $showDatePicker, todayDateComponent: $newItemAddedDate)
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
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Kembali"){
                        showSheet.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Tambah Pengeluaran").font(.headline)
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Simpan"){
                        //MARK: Call to save
                        let newExpense = UserExpense(id: UUID().uuidString, expenseName: newItemName, expensePrice: newItemPrice, expenseDate: newItemAddedDate, expenseCategory: newItemCategory, expenseDesc: newItemDesc, expenseTag: newItemTag)
                        
                        presenter.writeExpense(expense: newExpense)
                        
                        dateNotif.send(newItemAddedDate)
                        showSheet = false
                    }
                    .disabled(!inputValid || !priceValid || newItemTag == "")
                }
            }
        }
        
    }
    
    
//    struct NewItemView_Previews: PreviewProvider {
//        static var previews: some View {
//            NewItemView(showSheet: .constant(false), todayDateComponent: .constant(Date()))
//        }
//    }
}
