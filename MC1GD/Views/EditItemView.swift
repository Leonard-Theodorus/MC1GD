//
//  EditItemView.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 22/12/23.
//

import SwiftUI
import Combine
struct EditItemView: View {
    private let categories = ["Makanan dan Minuman", "Transportasi", "Barang"]
    @FocusState private var focusedField: Field?
    @Binding var showSheet : Bool
    @StateObject var formVm = FormViewModel()
    @State var newItemImage = UIImage()
    
    @Binding var newItemPrice : String
    @Binding var num : Double
    @Binding var newItemCategory : String
    @Binding var newItemTag : String
    @Binding var newItemDesc : String
    @Binding var newItemName : String
    var itemId : String

    
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var isFocusedName : Bool
    @FocusState var isFocusedPrice : Bool
    @FocusState var isFocusedDesc : Bool
    @State var isNeeds : Bool = false
    @State var isWants : Bool = false
    @State private var maxChars: Int = 50
    @State var isZeroPrice: Bool = false
    @State var showQuestions = false
    @Binding var todayDateComponent : Date
    @State var showDatePicker : Bool = false
    @State var showDeleteIcon : Bool = false
    @State var priceValid : Bool = true
    
    
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
                                itemNameTextField(formVm: formVm)
                                    .focused($focusedField, equals: Field.itemName)
                                    .onTapGesture {
                                        focusedField = Field.itemName
                                    }
                            }.padding(.vertical, 5)
                            if !formVm.textIsValid && focusedField == .itemName{
                                Text("Harus diisi, tidak diawali ataupun diakhiri dengan spasi")
                                    .foregroundColor(.red)
                                    .font(.caption2)
                                    .multilineTextAlignment(.leading)
                                    .padding(.leading,60)
                            }else if formVm.textIsValid && focusedField == .itemName {
                                Image(systemName: "checkmark").foregroundColor(.green)
                                    .padding(.horizontal,15)
                            }
                        }
                        Divider()
                        
                        
                        // MARK: pilih itemCategory
                        Group {
                            itemCategoryPicker(newItemCategory: $newItemCategory)
                        }
                        // MARK:  pilih itemTag needs/wants
                        Group {
                            itemTagField(isNeeds: $isNeeds, isWants: $isWants, showQuestions: $showQuestions, newItemTag: $newItemTag)
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
                            datePickerField(showDatePicker: $showDatePicker, todayDateComponent: $todayDateComponent)
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
                formVm.itemName = newItemName
                formVm.textIsValid = true
                formVm.buttonDeleteOn = true
                if newItemTag == "Kebutuhan"{
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
                    Text("Tambah Pengeluaran").font(.headline)
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Simpan"){
                        viewModel.editExpense(itemId: itemId, newDate: todayDateComponent, newPrice: newItemPrice, newName: formVm.itemName, newDescription: newItemDesc, newCategory: newItemCategory, newItemTag: newItemTag)
                       
                        dateNotif.send(todayDateComponent)
                        showSheet = false
                    }
                    .disabled(!formVm.textIsValid || !priceValid || newItemTag == "")
                }
            }
        }
    }
}

//#Preview {
//    EditItemView()
//}
