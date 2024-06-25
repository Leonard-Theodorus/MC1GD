//
//  SavingsView.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 04/05/23.
//

import SwiftUI

struct SavingsView: View {
    
    @State private var showSheet = false
    @State var presenter : SavingsListPresenter
    @Binding var todayDateComponent : Date
    @State private var stringDate = ""
    @State var userSavings : [UserSaving] = []
    @State var userTotalSavings : Double = 0
    @State var userTotalSavingsToday : Double = 0
    
    var body: some View {
        VStack(alignment: .leading){
            // MARK: title & addItemButton
            HStack(alignment: .center){
                Text("Tabungan")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                Spacer()
                AddSavingButton(todayDateComponent: $todayDateComponent, presenter: $presenter)
            }
            // MARK: Hello Card
            VStack(alignment: .leading){
                HStack{
                    Image("rp")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 20, height: 20)
                    Text("Total Tabunganmu")
                        .font(.title3)
                        .fontWeight(.light)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top)
                Text(currencyFormatter.string(from: NSNumber(value: userTotalSavings )) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom,5)
                
                if userTotalSavingsToday == 0 {
                    Text("Ayo semangat menabung!")
                        .font(.body)
                        .fontWeight(.light)
                        .italic()
                        .padding(.leading)
                        .padding(.bottom)
                }else{
                    HStack{
                        Image(systemName: "triangle.fill")
                            .resizable()
                            .frame(width: 10,height: 10)
                            .padding(0)
                        Image(systemName: "plus")
                            .resizable()
                            .frame(width: 10,height: 10)
                            .padding(0)
                        Text("\(currencyFormatter.string(from: NSNumber(value: userTotalSavingsToday )) ?? "") Hari ini")
                    }
                    .padding(.horizontal,12)
                    .padding(.vertical,3)
                    .foregroundColor(Color.primary_green)
                    .background(Color.white)
                    .cornerRadius(30)
                    .padding(.leading)
                    .padding(.bottom)
                }
                
            }
            .padding(.vertical,8)
            .foregroundColor(.white)
            .background(
                ZStack{
                    LinearGradient(colors: [Color("primary-purple"),Color("secondary-purple")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    HStack{
                        Spacer()
                        VStack{
                            Spacer()
                            Image("beruang-welcome")
                                .resizable()
                                .scaledToFit()
                                .frame(height: 100)
                        }
                        .padding(.trailing)
                        
                    }
                }
                
            )
            .cornerRadius(22)
            
            // MARK: Tabungan History Card
            if userSavings.isEmpty{
                EmptyData(desc: "Belum ada tabungan")
                    .foregroundColor(Color.secondary_gray)
                    .padding()
                    .padding(.top,3)
                    .background(.white)
                    .cornerRadius(22)
                    .padding(.top)
                    .shadow(color: Color.gray, radius: 4, y: 2)
            }
            else{
                SavingListView(userSavings: $userSavings)
            }
        }
        .padding(.horizontal,22)
        .onAppear{
            presenter.view = self
            presenter.interactor = SavingsListInteractorImplementation()
            presenter.interactor?.output = presenter as? SavingsListPresenterImplementation
            DispatchQueue.main.async {
                presenter.fetchSavings()
            }
        }
        
        
    }
}

//struct SavingsView_Previews: PreviewProvider {
//    static var previews: some View {
//        SavingsView(todayDateComponent: .constant(Date()))
//            .environmentObject(coreDataViewModel())
//    }
//}

extension SavingsView : SavingPresenterToView{
    func finishLoading(savings: [UserSaving], totalSavings: Double) {
        withAnimation {
            userSavings = savings
            userTotalSavings = totalSavings
        }
        for saving in userSavings {
            if saving.dateAdded == todayDateComponent.formateSavingsDate(for: todayDateComponent){
                userTotalSavingsToday += saving.savingAmount
            }
        }
    }
}
