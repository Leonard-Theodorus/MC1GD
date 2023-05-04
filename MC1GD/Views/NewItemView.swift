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
    @Binding var todayDateComponent : Date
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                VStack(alignment: .leading){
                    // MARK: input harga barang
                    HStack{
                        Text("Rp")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal,10)
                            .padding(.vertical,6)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray)
                                    .background(Color("tertiary-gray").cornerRadius(10)))
                            .foregroundColor(Color("primary-gray"))
                            .frame(width: 40)
                        Divider()
                        TextField("Harga Barang", value: $newItemPrice, format: .number)
                            .lineLimit(0)
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
                            .font(.title)
                        if isZeroPrice {
                            Text("Harga tidak boleh 0")
                                .foregroundColor(.red).font(.caption)
                        }
                    }
                    
                    Divider()
                    
                    // MARK: input nama barang
                    HStack{
                        Text("Aa")
                            .font(.headline)
                            .foregroundColor(Color.primary_gray)
                            .padding(.horizontal,15)
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
                                    .buttonStyle(.borderless)
                                    .clipped()
                                    .opacity(formVm.buttonDeleteOn ? 1.0 : 0.0)
                                    
                                }
                                , alignment: .trailing
                            )
                            .focused($isFocusedName)
                        
                    }.padding(.vertical, 5)
                    if !formVm.textIsValid{
                        Text("Harus diisi, tidak diawali ataupun diakhiri dengan spasi")
                            .foregroundColor(.red)
                            .font(.caption2)
                            .multilineTextAlignment(.leading)
                            .padding(.leading,60)
                    }else{
                        Image(systemName: "checkmark").foregroundColor(.green)
                            .padding(.horizontal,15)
                    }
                    
                    Divider()
                    
                    // MARK: pilih itemCategory
                    HStack{
                        Image(systemName: "circle.fill")
                            .imageScale(.large)
                            .foregroundColor(Color.primary_gray)
                            .padding(.horizontal,15)
                        HStack {
                            Picker("", selection: $newItemCategory) {
                                ForEach(categories, id: \.self){ category in
                                    Text(category)
                                }
                            }
                            .pickerStyle(.menu)
                            .tint(Color.primary)
                            .clipped()
                        }
                    }.padding(.vertical, 5)
                    
//                    Divider()
                    
                    // MARK:  pilih itemTag needs/wants
                    VStack {
                        HStack{
                            Image(systemName: "tag")
                                .imageScale(.large)
                                .foregroundColor(Color.primary_gray)
                                .padding(.horizontal,15)
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
                                    .textCase(.uppercase)
                                
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .background(Color.tag_pink)
                            .cornerRadius(25)
                            .shadow(radius: self.isWants ? 5:0)
                            .hoverEffect(.lift)
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
                                    .textCase(.uppercase)
                                
                            }
                            .buttonStyle(.bordered)
                            .foregroundColor(.white)
                            .background(
                                Color.tag_purple
                            )
                            .cornerRadius(25)
                            .shadow(radius: self.isNeeds ? 5:0)
                            .hoverEffect(.lift)
                            
                            
                            
                            
                            Button{
                                showQuestions.toggle()
                            } label: {
                                Image(systemName: "questionmark.circle.fill")
                                    .foregroundColor(Color("secondary-gray"))
                            }
                            .buttonStyle(.borderless)
                            .sheet(isPresented: $showQuestions) {
                                QuestionsView(showQuestions: $showQuestions)
                            }
                            
                            
                        }
                    }
                    .padding(.top, 15)
                    .padding(.bottom, 5)
                    
                    
                    // MARK:  input deskripsi item
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
                    }.padding(.vertical, 10)
                    
                    
                    // MARK: select tanggal
                    HStack{
                        Image(systemName: "calendar")
                            .imageScale(.large)
                            .foregroundColor(Color("secondary-gray"))
                            .padding(.horizontal,15)
                        
                        Text(Date().formatDateFull(for: todayDateComponent))
                            .font(.body)
                            .padding(.vertical,8)
                            .padding(.horizontal,10)
                            .foregroundColor(.black)
                        
                    }
                    HStack{
                        DatePicker("" ,selection: $todayDateComponent, in: ...Date(), displayedComponents: .date).datePickerStyle(.wheel)
                            .accentColor(Color.primary_purple)
                    }
                    
                    
                }
                .padding(.horizontal,20)
                .padding(.bottom, 30)
                
                
                Spacer()
                
                
            }
            //            .padding(.bottom, 50)
            .onAppear{
                newItemCategory = categories.first!}
            .toolbar{
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Kembali"){
                        showSheet.toggle()
                    }
                }
                ToolbarItem(placement: .principal) {
                    Text("Tambah Pengeluaran").font(.title3)
                    
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Simpan"){
                        
                        viewModel.addNewItem(date: todayDateComponent, price: newItemPrice, itemName: formVm.itemName, itemDescription: newItemDesc, itemCategory: newItemCategory, itemTag: newItemTag)
                        
                        dateNotif.send(todayDateComponent)
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
        NewItemView(showSheet: .constant(false), todayDateComponent: .constant(Date()))
    }
}
