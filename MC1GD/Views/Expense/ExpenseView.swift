
import SwiftUI


struct ExpenseView: View {
    
    @State var presenter : ExpenseListPresenter
    
    @State private var showSheet = false
    @Binding var todayDateComponent : Date
    @Binding var userName : String

    @State private var stringDate = ""
    @State private var showDatePicker = false
    @State private var categoryShow : CategoryPicker = .semua
    @State var allExpense : Double = 0
    @State var datebutton : Double = 0
    
    @State var userExpenses : [UserExpense] = []
    
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: title & addItemButton
            HStack(alignment: .center){
                Text("Pengeluaran")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AddItemButton(todayDateComponent: $todayDateComponent, presenter: $presenter)
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
                    CustomDatePicker(todayDateComponent: $todayDateComponent, showDatePicker: $showDatePicker, allExpense: $allExpense, presenter: $presenter)
                        .frame(width:85,height:30)
                        .zIndex(3)
                }
                .zIndex(2)
                // MARK: Segmented
                VStack{
                    Picker("Category", selection: $categoryShow){
                        Text("Semua").tag(CategoryPicker.semua)
                        Text("Keinginan").tag(CategoryPicker.keinginan)
                        Text("Kebutuhan").tag(CategoryPicker.kebutuhan)
                    }
                    .zIndex(1)
                    .pickerStyle(.segmented)
                    // MARK: Item List
                    if userExpenses.isEmpty {
                        // MARK: Show Empty
                        EmptyData(desc: "Belum ada pengeluaran")
                            .foregroundColor(Color.secondary_gray)
                            .background(.white)
                            .padding(.top)
                    }
                    switch categoryShow {
                        case .semua:
                            ItemListView(expenses: $userExpenses, presenter: $presenter)
                        case .keinginan:
                            @State var expensesTaggedWants = userExpenses.filter{$0.expenseTag == "Keinginan"}
                            ItemListView(expenses: $expensesTaggedWants, presenter: $presenter )
                        case .kebutuhan:
                            @State var expensesTaggedNeeds = userExpenses.filter{$0.expenseTag == "Kebutuhan"}
                            ItemListView(expenses: $expensesTaggedNeeds, presenter: $presenter)
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
            if userExpenses.isEmpty{
                //FIXME: Kalo bisa jangan ditaro sini
                let expenseInteractor = ExpenseInteractorImplementation()
                presenter.view = self
                presenter.interactor = expenseInteractor
                presenter.interactor?.output = presenter as? ExpenseListPresenterImplementation
                DispatchQueue.main.async {
                    withAnimation {
                        presenter.fetchExpense(date : todayDateComponent.formatExpenseDate(for: todayDateComponent))
                    }
                }
       
            }
        }
    }
}

extension ExpenseView : ExpensePresenterToView {
    func finishLoading(expenses: [UserExpense], totalExpense : Double) {
        withAnimation {
            userExpenses = expenses
            allExpense = totalExpense
        }
    }
}
