//
//  ContentView.swift
//  MC1
//
//  Created by Leonard Theodorus on 17/04/23.
//

import SwiftUI
struct InsightView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var showSheet = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @State private var todayDateComponent = Date()
    @State private var stringDate = ""
    @State private var swipeLeft = false
    @State private var swipeRight = false
    var body: some View {
        if viewModel.userItems.isEmpty{
            Text("There is no record yet")
            AddItemButton()
        }
        else{
            VStack{
                HStack{
                    Button{
                        withAnimation {
                            swipeLeft.toggle()
                        }
                    } label: {
                        Text(stringDate)
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
                            .opacity(swipeLeft ? 1 : 0)
                            .onChange(of: todayDateComponent, perform: { newValue in
                                withAnimation {
                                    swipeLeft.toggle()
                                }
                            })
                    )
//                    Button{
//                        swipeLeft.toggle()
//                        withAnimation {
//                            todayDateComponent = Date.dateStepBackward(Date())()
//                        }
//                    } label: {
//                        Image(systemName: "chevron.left")
//                    }
//                    Text(todayDateComponent).font(.title3)
//                    Button{
//                        swipeRight.toggle()
//                        withAnimation {
//                            todayDateComponent = Date.dateStepForward(Date())()
//                        }
//                    } label: {
//                        Image(systemName: "chevron.right")
//                    }
                }.onAppear{
                    stringDate = Date.formatDate(Date())()
                }
                //chart view
                List {
                    ForEach(viewModel.userItems) {item in
                        HStack{
                            Image(uiImage: UIImage(data: item.itemImage!)!).resizable().aspectRatio(contentMode: .fit)
                                .clipShape(Circle()).frame(width: 50, height: 50)
                            Spacer()
                            VStack{
                                Text(item.itemName!).font(.largeTitle)
                                Text(item.itemCategory!)
                                Text(item.itemTag!)
                            }
                            Spacer()
                            Text(item.itemPrice.formatted(.currency(code: "IDR")))
                        }.padding()
                            .swipeActions {
                                Button{
                                    viewModel.deleteItem(for:  item.itemId!)
                                } label: {
                                    Label("", systemImage: "trash")
                                }.tint(.red)
                                
                            }
                        
                    }
                    
                    
                }
                AddItemButton()
                
                
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
        }
        
        //        List(viewModel.userItems){item in
        //            Image(uiImage: UIImage(data: item.itemImage!)!).resizable().aspectRatio(contentMode: .fit)
        //        }
    }
    
}


struct InsightView_Previews: PreviewProvider {
    static var previews: some View {
        InsightView().environmentObject(coreDataViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
