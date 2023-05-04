
import SwiftUI

enum CategoryShow : Int{
    case semua = 0
    case keinginan = 1
    case kebutuhan = 2
}

struct ExpenseView: View {
    @State private var showSheet = false
    @EnvironmentObject var viewModel : coreDataViewModel
    @Binding var todayDateComponent : Date
    @State private var stringDate = ""
    @State private var showDatePicker = false
    @State private var categoryShow : CategoryShow = .semua
    @State var allExpense : Double = 0
    @State var datebutton : Double = 0
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: title & addItemButton
            HStack(alignment: .center){
                Text("Pengeluaran")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AddItemButton(todayDateComponent: $todayDateComponent)
            }
            // MARK: Hello Card
            VStack(alignment: .leading){
                HStack{
                    Image(systemName: "sun.min.fill")
                    Text("Hai,")
                        .font(.title2)
                        .fontWeight(.light)
                    Text(viewModel.getName())
                        .font(.title2)
                        .fontWeight(.semibold)
                    Spacer()
                }
                .padding()
                Text("Pengeluaranmu")
                    .fontWeight(.light)
                    .padding(.horizontal)
                Text(currencyFormatter.string(from: NSNumber(value: allExpense)) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
            .padding(.vertical,8)
            .foregroundColor(.white)
            .background(
                ZStack{
                    LinearGradient(colors: [Color("secondary-purple"),Color("primary-purple")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Image("beruang-expense")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 150)
                        }
                        
                    }
                }
            )
            .cornerRadius(22)
            
            // MARK: Expense Card
            VStack{
                HStack{
                    Text("Pengeluaran")
                        .font(.headline)
                        .foregroundColor(Color.primary_purple)
                        .frame(width: 100)
                    // MARK: Customized date picker
                    ZStack{
                        Button{
                            withAnimation {
                                showDatePicker.toggle()
                            }
                        }label: {
                            Text(Date().formatDateFrom(for: todayDateComponent))
                                .font(.caption)
                                .padding(.vertical,8)
                                .padding(.horizontal,10)
                                .foregroundColor(.white)
                                .frame(width: 85)
                                .background(
                                    RoundedRectangle(cornerRadius: 30)
                                        .stroke(lineWidth: 0)
                                        .background(Color.primary_purple.cornerRadius(20))
                                        .shadow(radius: 2)
                                )
                        }
                        .zIndex(3)
                        .padding(.leading,60)
                        .padding(.trailing,-60)
                        
                        HStack(alignment: .center){
                            DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                                .datePickerStyle(.graphical)
                                .background(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(lineWidth: 0)
                                        .background(Color.white.cornerRadius(20))
                                        .shadow(radius: 2)
                                    
                                )
                                .accentColor(Color.primary_purple)
                                .padding(10)
                                .opacity(showDatePicker ? 1 : 0)
                                .offset(y:160)
                                .frame(width: 280)
                                .onChange(of: todayDateComponent, perform: { newValue in
                                    DispatchQueue.main.async {
                                        withAnimation {
                                            showDatePicker.toggle()
                                            viewModel.fetchItems(for: todayDateComponent)
                                            allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                                        }
                                    }
                                    
                                    
                                })
                            
                        }
                        .zIndex(5)
                        .padding(.trailing,70)
                    }
                    .frame(height:55)
                    .zIndex(3)
                    .padding(.vertical,-30)
                    .padding(.leading,-70)
                    .padding(.trailing,-70)
                }
                .zIndex(2)
                //                .frame(maxWidth: 351)
                VStack{
                    Picker("Category", selection: $categoryShow){
                        Text("Semua").tag(CategoryShow.semua)
                        Text("Keinginan").tag(CategoryShow.keinginan)
                        Text("Kebutuhan").tag(CategoryShow.kebutuhan)
                    }
                    .zIndex(1)
                    .pickerStyle(.segmented)
                    
                    List {
                        ForEach(viewModel.userItems){ item in
                            if categoryShow == .keinginan && item.itemTag == "Keinginan" {
                                VStack{
                                    HStack(alignment: .top){
                                        Image(systemName: item.itemImage!)
                                            .resizable()
                                            .padding(12)
                                            .scaledToFit()
                                            .frame(width: 54,height: 54)
                                            .background(Color("primary-purple"))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                        VStack(alignment: .leading){
                                            Text(item.itemName!)
                                                .font(.headline)
                                                .padding(.bottom,-5)
                                            Text(item.itemTag!)
                                            //                                                .font(.caption2)
                                                .font(Font.custom("SF Pro", size: 8))
                                                .padding(8)
                                                .frame(height:15)
                                                .background(item.itemTag! == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                                .foregroundColor(.white)
                                                .textCase(.uppercase)
                                                .cornerRadius(3)
                                            Text(item.itemDescription!)
                                                .font(.caption2)
                                                .italic()
                                                .foregroundColor(Color("primary-gray"))
                                                .padding(.top,1)
                                                .lineSpacing(2)
                                        }
                                        Spacer()
                                        Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                            .foregroundColor(Color("primary-red"))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal,-1)
                                    .padding(.top)
                                    .swipeActions {
                                        Button{
                                            viewModel.deleteItem(for:  item.itemId!)
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }.tint(.red)
                                    }
                                    Rectangle()
                                        .foregroundColor(Color.tertiary_gray)
                                        .frame(height: 1)
                                        .padding(.vertical,2)
                                    
                                }
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                            }
                            else if categoryShow == .kebutuhan && item.itemTag == "Kebutuhan" {
                                VStack{
                                    HStack(alignment: .top){
                                        Image(systemName: item.itemImage!)
                                            .resizable()
                                            .padding(12)
                                            .scaledToFit()
                                            .frame(width: 54,height: 54)
                                            .background(Color("primary-purple"))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                        VStack(alignment: .leading){
                                            Text(item.itemName!)
                                                .font(.headline)
                                                .padding(.bottom,-5)
                                            Text(item.itemTag!)
                                            //                                                .font(.caption2)
                                                .font(Font.custom("SF Pro", size: 8))
                                                .padding(8)
                                                .frame(height:15)
                                                .background(item.itemTag! == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                                .foregroundColor(.white)
                                                .textCase(.uppercase)
                                                .cornerRadius(3)
                                            Text(item.itemDescription!)
                                                .font(.caption2)
                                                .italic()
                                                .foregroundColor(Color("primary-gray"))
                                                .padding(.top,1)
                                                .lineSpacing(2)
                                        }
                                        Spacer()
                                        Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                            .foregroundColor(Color("primary-red"))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal,-1)
                                    .padding(.top)
                                    .swipeActions {
                                        Button{
                                            viewModel.deleteItem(for:  item.itemId!)
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }.tint(.red)
                                    }
                                    Rectangle()
                                        .foregroundColor(Color.tertiary_gray)
                                        .frame(height: 1)
                                        .padding(.vertical,2)
                                    
                                }
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                            }
                            else if categoryShow == .semua {
                                VStack{
                                    HStack(alignment: .top){
                                        Image(systemName: item.itemImage!)
                                            .resizable()
                                            .padding(12)
                                            .scaledToFit()
                                            .frame(width: 54,height: 54)
                                            .background(Color("primary-purple"))
                                            .cornerRadius(10)
                                            .foregroundColor(.white)
                                        VStack(alignment: .leading){
                                            Text(item.itemName!)
                                                .font(.headline)
                                                .padding(.bottom,-5)
                                            Text(item.itemTag!)
                                            //                                                .font(.caption2)
                                                .font(Font.custom("SF Pro", size: 8))
                                                .padding(8)
                                                .frame(height:15)
                                                .background(item.itemTag! == "Kebutuhan" ? Color.tag_purple: Color.tag_pink)
                                                .foregroundColor(.white)
                                                .textCase(.uppercase)
                                                .cornerRadius(3)
                                            Text(item.itemDescription!)
                                                .font(.caption2)
                                                .italic()
                                                .foregroundColor(Color("primary-gray"))
                                                .padding(.top,1)
                                                .lineSpacing(2)
                                        }
                                        Spacer()
                                        Text("- \(currencyFormatter.string(from: NSNumber(value: item.itemPrice )) ?? "")")
                                            .foregroundColor(Color("primary-red"))
                                            .fontWeight(.bold)
                                    }
                                    .padding(.horizontal,-1)
                                    .padding(.top)
                                    .swipeActions {
                                        Button{
                                            viewModel.deleteItem(for:  item.itemId!)
                                        } label: {
                                            Label("", systemImage: "trash")
                                        }.tint(.red)
                                    }
                                    Rectangle()
                                        .foregroundColor(Color.tertiary_gray)
                                        .frame(height: 1)
                                        .padding(.vertical,2)
                                    
                                }
                                .listRowSeparator(.hidden)
                                .listRowInsets(EdgeInsets())
                            }
                        }
                    }
                    .listStyle(.plain)
                    .clipped()
                    
                }
                
                Spacer()
            }
            .padding()
            .background(.white)
            .cornerRadius(22)
            .shadow(color: Color.gray, radius: 4, y: 2)
            .padding(.top,12)
            .zIndex(1)
            //            .onTapGesture {showDatePicker = false}
            
        }
        .padding(.horizontal,22)
        .onAppear{
            DispatchQueue.main.async {
                withAnimation{
                    allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                }
            }
        }.onChange(of: viewModel.calculateAllExpense(for: todayDateComponent), perform: { newValue in
            withAnimation {
                allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
            }
        })
        
    }
}

struct ExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseView(todayDateComponent: .constant(Date()))
            .environmentObject(coreDataViewModel())
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
        
    }
}
