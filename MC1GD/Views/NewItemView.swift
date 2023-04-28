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
    @Binding var showSheet : Bool
    @StateObject var formVm = addItemFormViewModel()
    @State var newItemDate = Date()
    @State var newItemPrice : Double = 0.0
    @State var newItemImage = UIImage()
    @State var newItemCategory = ""
    @State var newItemTag : String = ""
    private let categories = ["Makanan dan Minuman", "Transportasi", "Barang"]
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var isFocused : Bool
    @State var isNeeds = false
    @State var isWants = false
//Progress:
//- added form validation not empty, not begin or ends with whitespace in add item form.
//- disabled auto correct on the add item form
    var body: some View {
        NavigationView {
            VStack{
                //TODO: tambahin item category/tag/add guiding questionnya kesini//
                Form {
                    Section{
                        TextField("Nama Barang", text: $formVm.itemName).autocorrectionDisabled(true)
                            .focused($isFocused)
                            .overlay (
                                ZStack{
                                    Button {
                                        withAnimation {
                                            formVm.deleteText()
                                        }
                                    } label: {
                                        Image(systemName: "delete.left").foregroundColor(.red)
                                    }
                                    .opacity(formVm.buttonDeleteOn ? 1.0 : 0.0)

                                }
                                , alignment: .trailing
                            )
                        if !formVm.textIsValid{
                            Text("Tolong isi nama barang")
                                .foregroundColor(.red)
                                .font(.caption)
                            Text("Nama barang tidak diawali ataupun diakhiri dengan spasi")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        else{
                            Image(systemName: "checkmark").foregroundColor(.green)
                        }
                    }
                    Section{
                        Text("Harga Barang")
                        HStack{
                            Text("Rp.")
                            Divider()
                            TextField("", value: $newItemPrice, format: .number).keyboardType(.numberPad).focused($isFocused)
                        }
                   
                    }
                    Section{
                        HStack{
                            Button{
                                if isWants != true{
                                    self.isNeeds.toggle()
                                    self.newItemTag = "Kebutuhan"
                                }else{
                                    self.isWants.toggle()
                                    self.isNeeds.toggle()
                                    self.newItemTag = "Kebutuhan"
                                }
                            } label: {
                                Text("Kebutuhan")
                                
                                .font(.body)
                                .bold()
                                .padding(2)

                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .background(self.isNeeds ? Color(.gray): Color(.blue))
                            .cornerRadius(15)
                            .hoverEffect(.lift)
                            
                            
                            Button{
                                if isNeeds != true {
                                    self.isWants.toggle()
                                    self.newItemTag = "Keinginan"
                                }else{
                                    self.isNeeds.toggle()
                                    self.isWants.toggle()
                                    self.newItemTag = "Keinginan"
                                }
                            } label: {
                                Text("Keinginan")
                                .font(.body)
                                .bold()
                                .padding(2)
                                            
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .background(self.isWants ? Color(.gray): Color(.red))
                            .cornerRadius(15)
                            .hoverEffect(.lift)
                            
                            
                        }
                        
                    }
                    Section{
                        Picker("Kategori", selection: $newItemCategory) {
                            ForEach(categories, id: \.self){ category in
                                Text(category)
                            }
                        }
                    }
                    Section{
                        Text("Tanggal Dibeli")
                        DatePicker("" ,selection: $newItemDate, in: ...Date(), displayedComponents: .date).datePickerStyle(.wheel)
                        
                    }
                    
                }
            }.onAppear{
                newItemCategory = categories.first!
            }
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel"){
                        showSheet.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Item Baru").font(.title3)
                        
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Add Item"){
                        viewModel.addNewItem(date: newItemDate, price: newItemPrice, itemName: formVm.itemName, itemDescription: "Test", itemCategory: newItemCategory, itemTag: newItemTag)
                        dateNotif.send(newItemDate)
                        showSheet = false
                    }.disabled(!formVm.textIsValid)
                }
            }
        }
        
    }
}

struct NewItemView_Previews: PreviewProvider {
    static var previews: some View {
        NewItemView(showSheet: .constant(false))
    }
}
