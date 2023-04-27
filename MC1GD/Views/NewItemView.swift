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
    @State var showImage = false
    @State var useCamera = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var isFocused : Bool
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
//                        Text("Tanggal")
//                        DatePicker("Tanggal", selection: $newItemDate, in: Date()... ).datePickerStyle(.graphical)
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
                        
                        DatePicker("" ,selection: $newItemDate, in: ...Date(), displayedComponents: .date).datePickerStyle(.wheel)
                        
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
                        viewModel.addNewItem(itemImage: newItemImage, date: newItemDate, price: newItemPrice, itemName: newItemName, itemDescription: "Test", itemCategory: "MISC", itemTag: "Wants")
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
