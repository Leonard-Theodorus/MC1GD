//
//  SummaryView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct SummaryView: View {
    @State private var todayDateComponent = Date()
    @State private var showDatePicker = false
    
    @EnvironmentObject var viewModel : coreDataViewModel

    var body: some View {
        VStack(alignment: .center){
            Text("Ringkasan")
                .foregroundColor(.green)
                .font(.title)
                .bold()
            
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
                        print(newValue)
                        withAnimation {
                            showDatePicker.toggle()
                            viewModel.fetchItems(for: todayDateComponent)
                        }
                    })
            )
            
            
            CategoryChart(todayDateComponent: $todayDateComponent)
            
        }
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
