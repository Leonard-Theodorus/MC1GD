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
    @State var newItemImage = UIImage()
    @State var newItemPrice = ""
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
    @State var showDatePicker : Bool = false
    @State var showDeleteIcon : Bool = false
    @State var priceValid : Bool = false
    @State var num : Double = 0
    @FocusState private var focusedField: Field?
    @State var const = ""
    var body: some View {
        NavigationView {
            VStack(alignment: .center){
                ScrollView {
                    VStack(alignment: .leading){
                        //                    TextField("SS", text: $const).hidden().focused($isFocusedPrice)
                        //                    TextField("SS", text: $const).hidden().focused($isFocusedPrice)
                        //                    TextField("SS", text: $const).hidden()
                        //                        .focused($isFocusedPrice)
                        // MARK: harga barang
                        Group {
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
                                Divider().frame(height: 30)
                                TextField("Harga Barang", text: $newItemPrice)
                                    .disableAutocorrection(true)
                                    .lineLimit(0)
                                    .keyboardType(.numberPad)
                                    .font(.title2)
                                
                                    .onChange(of: newItemPrice) { newValue in
                                        withAnimation {
                                            let numberString = newValue.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                                            if let number = Double(numberString) {
                                                num = number
                                                newItemPrice = currencyFormatterInForm.string(from: NSNumber(value: num)) ?? ""
                                            }
                                            if (numberString != "0" && numberString != ""){
                                                priceValid = true
                                            }
                                            else{
                                                priceValid = false
                                            }
                                        }
                                        
                                    }
                                    .overlay (
                                        ZStack{
                                            Button {
                                                withAnimation {
                                                    newItemPrice = ""
                                                }
                                            } label: {
                                                Image(systemName: "delete.left").foregroundColor(.red)
                                            }
                                            .buttonStyle(.borderless)
                                            .clipped()
                                            .opacity(priceValid ? 1.0 : 0.0)
                                            
                                        }
                                        , alignment: .trailing
                                    )
                                    .focused($focusedField, equals: Field.itemPrice)
                                    .onTapGesture {
                                        focusedField = Field.itemPrice
                                    }
                                
                            }
                            .padding(.bottom,5)
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
                        
                        // MARK: nama barang
                        Group {
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
                            
                            Divider()
                        }
                        
                        // MARK: pilih itemCategory
                        Group {
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
                            Divider()
                        }
                        
                        
                        // MARK:  pilih itemTag needs/wants
                        Group {
                            VStack (alignment: .leading){
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
                                    .background(
                                        Color.tag_pink
                                            .opacity(self.isWants ? 1: 0.4)
                                    )
                                    .cornerRadius(25)
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
                                            .opacity(self.isNeeds ? 1: 0.4)
                                    )
                                    .cornerRadius(25)
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
                                Text("Pilih Salah Satu")
                                    .font(.caption2)
                                    .padding(.leading,75)
                                    .italic()
                                    .foregroundColor(Color.secondary_gray)
                            }
                            .padding(.top,5)
                            Divider()
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
                            HStack{
                                Image(systemName: "calendar")
                                    .imageScale(.large)
                                    .foregroundColor(Color("secondary-gray"))
                                    .padding(.horizontal,15)
                                
                                Button{
                                    showDatePicker.toggle()
                                }label:{
                                    Text(Date().formatDateFull(for: todayDateComponent))
                                        .font(.body)
                                        .padding(.vertical,8)
                                        .padding(.horizontal,10)
                                        .foregroundColor(.black)
                                        .background(
                                            RoundedRectangle(cornerRadius: 10)
                                                .stroke(Color.tertiary_gray)
                                        )
                                }
                                
                            }.padding(.top,10)
                            if showDatePicker == true{
                                HStack{
                                    DatePicker("" ,selection: $todayDateComponent, in: ...Date(), displayedComponents: .date).datePickerStyle(.wheel)
                                        .accentColor(Color.primary_purple)
                                }
                            }
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
                newItemCategory = categories.first!}
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
                        viewModel.addNewItem(date: todayDateComponent, price: newItemPrice.stripComma(for: newItemPrice), itemName: formVm.itemName, itemDescription: newItemDesc, itemCategory: newItemCategory, itemTag: newItemTag)
                        
                        dateNotif.send(todayDateComponent)
                        showSheet = false
                    }
                    .disabled(!formVm.textIsValid || !priceValid || newItemTag == "")
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
