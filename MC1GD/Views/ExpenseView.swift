
import SwiftUI

enum CategoryShow : Int{
    case semua = 0
    case keinginan = 1
    case kebutuhan = 2
}

struct ExpenseView: View {
    @State private var userName : String = ""
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
            HelloCard(allExpense: $allExpense, userName: $userName)
            
            // MARK: Expense Card
            VStack{
                HStack{
                    Text("Pengeluaran")
                        .font(.headline)
                        .foregroundColor(Color.primary_purple)
                        .frame(width: 100)
                    Spacer()
                    // MARK: Customized date picker
                    CustomDatePicker(todayDateComponent: $todayDateComponent, showDatePicker: $showDatePicker, allExpense: $allExpense)
                        .frame(width:85,height:30)
                        .zIndex(3)
                }
                .zIndex(2)
                // MARK: Segmented
                VStack{
                    Picker("Category", selection: $categoryShow){
                        Text("Semua").tag(CategoryShow.semua)
                        Text("Keinginan").tag(CategoryShow.keinginan)
                        Text("Kebutuhan").tag(CategoryShow.kebutuhan)
                    }
                    .zIndex(1)
                    .pickerStyle(.segmented)
                    // MARK: Item List
                    if (categoryShow == .semua && !viewModel.userItems.isEmpty) || (categoryShow == .keinginan && !viewModel.userItems.filter{$0.itemTag == "Keinginan"}.isEmpty) || (categoryShow == .kebutuhan && !viewModel.userItems.filter{$0.itemTag == "Kebutuhan"}.isEmpty) {
                        ItemListView(categoryShow: $categoryShow, confirmButton: false)
                    } else {
                        // MARK: Show Empty
                        EmptyData(desc: "Belum ada pengeluaran")
                            .foregroundColor(Color.secondary_gray)
                            .background(.white)
                            .padding(.top)
                    }
                }
                Spacer()
            }
            .padding()
            .background(.white)
            .cornerRadius(22)
            .shadow(color: Color.gray, radius: 4, y: 2)
            .padding(.top,12)
            .zIndex(1)
            
            
        }
        .padding(.horizontal,22)
        .onAppear{
            DispatchQueue.main.async {
                withAnimation{
                    allExpense = viewModel.calculateAllExpense(for: todayDateComponent)
                    userName = viewModel.getName()
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
