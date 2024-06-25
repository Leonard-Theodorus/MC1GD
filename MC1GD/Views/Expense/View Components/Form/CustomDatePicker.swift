//
//  CustomDatePicker.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct CustomDatePicker: View {
    @Binding var todayDateComponent : Date
    @Binding var showDatePicker : Bool
    @Binding var allExpense : Double
    @Binding var presenter : ExpenseListPresenter
    var body: some View {
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
            
            HStack(alignment: .center){
                DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                    .datePickerStyle(.graphical)
                    .environment(\.locale, Locale.init(identifier: "ID"))
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(lineWidth: 0)
                            .background(Color.white.cornerRadius(20))
                            .shadow(radius: 2)
                        
                    )
                    .accentColor(Color.primary_purple)
                    .padding(10)
                    .opacity(showDatePicker ? 1 : 0)
                    .offset(x: -90, y :160)
                    .frame(width: 280)
                    .onChange(of: todayDateComponent, perform: { newValue in
                        DispatchQueue.main.async {
                            withAnimation {
                                showDatePicker.toggle()
                                presenter.fetchExpense(date: todayDateComponent.formatExpenseDate(for: todayDateComponent))
                            }
                        }
                    })
                
            }
            .zIndex(5)
        }
    }
}

//struct CustomDatePicker_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomDatePicker(todayDateComponent: .constant(Date()), showDatePicker: .constant(false), allExpense: .constant(0))
//    }
//}
