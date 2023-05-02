//
//  ExpenseView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import SwiftUI

struct ExpenseView: View {
    @State private var showSheet = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var todayDateComponent : Date
    @State private var stringDate = ""
    @State private var showDatePicker = false
    var body: some View {
        
        if viewModel.userItems.isEmpty{
            HStack{
                Spacer()
                Button{
                    withAnimation {
                        showDatePicker.toggle()
                    }
                } label: {
                    Text(Date().formatDateFrom(for: todayDateComponent))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray)
                        )
                }
                .background(
                    DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                        .datePickerStyle(.graphical)
                        .clipped()
                        .background(Color.gray.cornerRadius(10))
                        .opacity(showDatePicker ? 1 : 0)
                        .offset(y: 50)
                        .onChange(of: todayDateComponent, perform: { newValue in
                            DispatchQueue.main.async {
                                withAnimation {
                                    showDatePicker.toggle()
                                    viewModel.fetchItems(for: todayDateComponent)
                                }
                            }
                            
                        })
                ).padding(.trailing,70)
                AddItemButton(todayDateComponent: $todayDateComponent)
            }.onReceive(dateNotif, perform: { date in
                todayDateComponent = date
            })
            .onAppear{
                stringDate = Date().formatDate()
            }.padding()
            Text("There is no record yet").padding(.top,30)
            
//            AddItemButton()
        }
        else{
            VStack{
                HStack{
                    Spacer()
                    Button{
                        withAnimation {
                            showDatePicker.toggle()
                        }
                    } label: {
                        Text(Date().formatDateFrom(for: todayDateComponent))
                            .padding()
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray)
                            )
                    }
                    .background(
                        DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                            .datePickerStyle(.compact)
                            .clipped()
                            .background(Color.gray.cornerRadius(10))
                            .opacity(showDatePicker ? 1 : 0)
                            .offset(y: 50)
                            .zIndex(1)
                            .onChange(of: todayDateComponent, perform: { newValue in
                                withAnimation {
                                    showDatePicker.toggle()
                                    viewModel.fetchItems(for: newValue)
                                }
                            })
                    ).padding(.trailing,60)
                    AddItemButton(todayDateComponent: $todayDateComponent)
                }.zIndex(2)
                .onAppear{
                    stringDate = Date.formatDate(Date())()
                }.padding()
                List {
                    ForEach(viewModel.userItems) {item in
                        HStack{
                            Image(uiImage: UIImage(data: item.itemImage!)!)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Rectangle())
                                .frame(width: 50, height: 50)
                            Spacer()
                            VStack{
                                Text(item.itemName!).font(.largeTitle)
                                Text(item.itemCategory!)
                                Text(item.itemTag!)
                                Text(item.itemDescription ?? "").font(.caption)
                            }
                            Spacer()
//                            Text(item.itemPrice.formatted(.currency(code: "IDR")))
                            Text(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")
                        }
                        .padding()
                            .swipeActions {
                                Button{
                                    viewModel.deleteItem(for:  item.itemId!)
                                } label: {
                                    Label("", systemImage: "trash")
                                }.tint(.red)
                                
                            }
                        
                    }
                }
//                AddItemButton()
                
                
                //            HStack{
                //                Image(uiImage: self.selectedImageData)
                //                        .resizable()
                //                        .cornerRadius(50)
                //                        .padding(.all, 4)
                //                        .frame(width: 100, height: 100)
                //                        .background(Color.black.opacity(0.2))
                //                        .aspectRatio(contentMode: .fill)
                //                        .clipShape(Circle())
                //                        .padding(8)
                //                Text("Change photo")
                //                    .font(.headline)
                //                    .frame(maxWidth: .infinity)
                //                    .frame(height: 50)
                //                    .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.262745098, green: 0.0862745098, blue: 0.8588235294, alpha: 1)), Color(#colorLiteral(red: 0.5647058824, green: 0.462745098, blue: 0.9058823529, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                //                    .cornerRadius(16)
                //                    .foregroundColor(.white)
                //                    .onTapGesture {
                //                        showSheet = true
                //                    }
                //                    .sheet(isPresented: $showSheet) {
                //                        ImagePicker(sourceType: .camera, selectedImage: self.$selectedImageData)
                //                        // bikin logic buat milih dia bisa pake camera / galery
                //                    }
                //            }
                //            Button{
                //                testImg =  viewModel.encodeImage(for: selectedImageData)
                //                viewModel.addNewItem(itemImage: testImg)
                //                uploaded.toggle()
                //            }label: {
                //                Text("Save")
                //            }
                //            if uploaded{
                //                List(viewModel.userItems) {item in
                //                    Image(uiImage: UIImage(data: item.itemImage!)!).resizable().aspectRatio(contentMode: .fit)
                //                }
                //
                //            }
                
            }
            .onReceive(dateNotif, perform: { date in
                todayDateComponent = date
            })
        }
        
        //        List(viewModel.userItems){item in
        //            Image(uiImage: UIImage(data: item.itemImage!)!).resizable().aspectRatio(contentMode: .fit)
        //        }
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(todayDateComponent: .constant(Date())).environmentObject(coreDataViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
