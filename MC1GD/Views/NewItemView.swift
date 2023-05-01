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
    @State var newItemPrice : Double = 0
    @State var newItemImage = UIImage()
    @State var newItemCategory = ""
    @State var newItemTag : String = ""
    @State var newItemDesc : String = ""
    private let categories = ["Makanan dan Minuman", "Transportasi", "Barang"]
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var isFocusedName : Bool
    @FocusState var isFocusedPrice : Bool
    @FocusState var isFocusedDesc : Bool
    @State var isNeeds = false
    @State var isWants = false
    @State private var maxChars: Int = 50
    @State var isZeroPrice: Bool = false
    @State var showQuestions = false
    var body: some View {
        NavigationView {
            VStack{
                //TODO: tambahin item category/tag/add guiding questionnya kesini
                Form {
                    VStack(alignment: .leading){
                        // MARK: input harga barang
                        HStack{
                            Text("Rp")
                                .foregroundColor(Color("secondary-gray"))
                            Divider()
                            TextField("Harga Barang", value: $newItemPrice, format: .number)
                                .keyboardType(.numberPad)
                                .focused($isFocusedPrice)
                                .onReceive(Just(newItemPrice)){ newValue in
                                    isZeroPrice = isFocusedPrice && newValue <= 0
                                }
                                .onChange(of: isFocusedPrice){ newValue in
                                    if !newValue{
                                        isZeroPrice = newItemPrice <= 0
                                    }
                                }
                                .foregroundColor(newItemPrice <= 0 ? .gray : .black)
                                .font(.largeTitle)
                            if isZeroPrice {
                                Text("Harga tidak boleh 0")
                                    .foregroundColor(.red).font(.caption)
                            }
                        }
                        
                        Divider()
                        
                        // MARK: input nama barang
                        HStack{
                            Text("Aa")
                                .foregroundColor(Color("secondary-gray"))
                            TextField("Nama Barang", text: $formVm.itemName).autocorrectionDisabled(true)
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
                                .focused($isFocusedName)
                            
                        }.padding(.vertical, 5)
                        if !formVm.textIsValid{
                            
                            Text("Nama barang harus diisi, tidak diawali ataupun diakhiri dengan spasi.")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                        else{
                            Image(systemName: "checkmark").foregroundColor(.green)
                        }
                        
                        Divider()
                        
                        // MARK: pilih itemCategory
                        HStack{
                            Image(systemName: "circle.fill")
                                .imageScale(.large)
                                .foregroundColor(Color("secondary-gray"))
                            Picker("", selection: $newItemCategory) {
                                ForEach(categories, id: \.self){ category in
                                    Text(category)
                                }
                            }
                        }.padding(.vertical, 5)
                        
                        Divider()
                        
                        // MARK:  pilih itemTag needs/wants
                        VStack {
                            HStack{
                                Image(systemName: "tag")
                                    .imageScale(.large)
                                    .foregroundColor(Color("secondary-gray"))
                                Button{
                                    if isWants != true{
                                        if isNeeds != true {
                                            self.isNeeds.toggle()
                                            self.newItemTag = "Kebutuhan"
                                        }else{
                                            self.isNeeds.toggle()
                                            self.newItemTag = ""
                                        }
                                    }else{
                                        self.isWants.toggle()
                                        self.isNeeds.toggle()
                                        self.newItemTag = "Kebutuhan"
                                    }
                                } label: {
                                    Text("Kebutuhan")
                                        .font(.caption)
                                        .bold()
                                        .padding(2)
                                    
                                }
                                .buttonStyle(.bordered)
                                .foregroundColor(.white)
                                .background(self.isNeeds ? Color(.gray): Color("primary-orange"))
                                .cornerRadius(25)
                                .hoverEffect(.lift)
                                
                                
                                Button{
                                    if isNeeds != true {
                                        if isWants != true {
                                            self.isWants.toggle()
                                            self.newItemTag = "Keinginan"
                                        }else{
                                            self.isWants.toggle()
                                            self.newItemTag = ""
                                        }
                                    }else{
                                        self.isNeeds.toggle()
                                        self.isWants.toggle()
                                        self.newItemTag = "Keinginan"
                                    }
                                } label: {
                                    Text("Keinginan")
                                        .font(.caption)
                                        .bold()
                                        .padding(2)
                                    
                                }
                                .buttonStyle(.bordered)
                                .foregroundColor(.white)
                                .background(self.isWants ? Color(.gray): Color(.red))
                                .cornerRadius(25)
                                .hoverEffect(.lift)
                                
                                Button{
                                showQuestions.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(Color("secondary-gray"))
                            }
                            .sheet(isPresented: $showQuestions) {
                                QuestionsView()
                            }
                                
                                
                            }
                        }
                        .padding(.top, 15)
                        .padding(.bottom, 5)
                        
                        //                        Divider()
                        
                        // MARK:  input deskripsi item
                        VStack {
                            HStack(alignment: .top){
                                Image(systemName: "text.alignleft")
                                    .imageScale(.large)
                                    .foregroundColor(Color("secondary-gray"))
                                TextField("Deskripsi (50 Karakter)", text: $newItemDesc, axis: .vertical)
                                    .focused($isFocusedDesc)
                                    .lineLimit(5, reservesSpace: true)
                                    .disableAutocorrection(true)
                                    .textFieldStyle(.roundedBorder)
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
                        }.padding(.vertical, 10)
                        
                        //                        Divider()
                        
                        // MARK: select tanggal
                        HStack{
                            Image(systemName: "calendar")
                                .imageScale(.large)
                                .foregroundColor(Color("secondary-gray"))
                            DatePicker("" ,selection: $newItemDate, in: ...Date(), displayedComponents: .date).datePickerStyle(.compact)
                        }
                    
                    }
                    .background(Color("primary-white"))
                    .padding(.vertical)
                    
                }
                .background(Color("primary-white"))
            }
            .background(Color("primary-white"))
            .onAppear{
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
                        
                        viewModel.addNewItem(date: newItemDate, price: newItemPrice, itemName: formVm.itemName, itemDescription: newItemDesc, itemCategory: newItemCategory, itemTag: newItemTag)
                        
                        dateNotif.send(newItemDate)
                        showSheet = false
                    }
                    .disabled(!formVm.textIsValid || newItemPrice <= 0 || newItemTag == "")
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
