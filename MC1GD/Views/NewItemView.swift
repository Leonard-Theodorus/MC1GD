//
//  NewItemView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import SwiftUI

struct NewItemView: View {
    @Binding var showSheet : Bool
    @State var newItemName = ""
    @State var newItemDate = Date()
    @State var newItemPrice : Double = 0.0
    @State var newItemImage = UIImage()
    @State var newItemTag = ""
    @State var showImage = false
    @State var useCamera = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var isFocused : Bool
    @State var isNeeds = false
    @State var isWants = false
    
    var body: some View {
        NavigationView {
            VStack{
                Form {
                    Section{
                        TextField("Nama Barang", text: $newItemName).focused($isFocused)
                    }
                    Section{
                        Text("Harga Barang")
                        TextField("Harga Barang", value: $newItemPrice, format: .number).keyboardType(.numberPad).focused($isFocused)
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
                        Text("Gambar Barang")
                        HStack{
                            Image(uiImage: newItemImage)
                                     .resizable()
                                     .cornerRadius(50)
                                     .padding(.all, 4)
                                     .frame(width: 100, height: 100)
                                     .background(Color.black.opacity(0.2))
                                     .aspectRatio(contentMode: .fill)
                                     .clipShape(Circle())
                                     .padding(8)
                            Button{
                                showImage.toggle()
                            } label: {
                                Text("Pilih Gambar").onTapGesture {
                                    showImage.toggle()
                                }
                                            
                            }
                            .sheet(isPresented: $showImage) {
                                ImagePicker(selectedImage: $newItemImage)
                            }
                            Spacer()
                            Button{
                                useCamera.toggle()
                            } label: {
                                Text("Ambil Gambar").onTapGesture {
                                    useCamera.toggle()
                                }
                            }.sheet(isPresented: $useCamera) {
                                ImagePicker(sourceType: .camera,selectedImage: $newItemImage)
                            }
                        }
                    }
                    Section{
                        Text("Tanggal Dibeli")
                        
                        DatePicker("Tanggal" ,selection: $newItemDate, displayedComponents: .date)
                        
                    }
                    
                }
            }.onTapGesture {
                isFocused = false
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
                        viewModel.addNewItem(itemImage: newItemImage, date: newItemDate, price: newItemPrice, itemName: newItemName, itemDescription: "Test", itemCategory: "MISC", itemTag: newItemTag)
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
