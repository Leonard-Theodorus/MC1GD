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
    @State var newItemName = ""
    @State var newItemDate = Date()
    @State var newItemPrice : Double = 0.0
    @State var newItemImage = UIImage()
    @State private var newItemCategory = ""
    @State var newItemTag : String = ""
    private let categories = ["Makanan dan Minuman", "Transportasi", "Barang"]
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var isFocused : Bool
    @State var isNeeds = false
    @State var isWants = false
    
    var body: some View {
        NavigationView {
            VStack{
                //TODO: tambahin item category/tag/add guiding questionnya kesini//
                Form {
                    Section{
                        TextField("Nama Barang", text: $newItemName).focused($isFocused)
                    }
                    Section{
                        Text("Harga Barang")
                        HStack{
                            Text("Rp.")
                            Divider()
                            TextField("Harga Barang", value: $newItemPrice, format: .number).keyboardType(.numberPad).focused($isFocused)
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
                        
                    }
                    Section{
                        Text("Tanggal Dibeli")
                        DatePicker("" ,selection: $newItemDate, in: ...Date(), displayedComponents: .date).datePickerStyle(.wheel)
                        
                    }
                    
                }
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
                        viewModel.addNewItem(date: newItemDate, price: newItemPrice, itemName: newItemName, itemDescription: "Test", itemCategory: "MISC", itemTag: newItemTag)
                        dateNotif.send(newItemDate)
                        showSheet = false
                    }
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
