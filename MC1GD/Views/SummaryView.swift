//
//  SummaryView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct SummaryView: View {
    @Binding var todayDateComponent : Date
    @State private var showDate = false
    @EnvironmentObject var viewModel : coreDataViewModel
    var body: some View {
        VStack(alignment: .leading){
            Text("Ringkasan")
                .foregroundColor(.black)
                .font(.title)
                .bold()
                .padding(.leading, 15)
            
            VStack (alignment: .center){
                Button{
                    withAnimation {
                        showDate.toggle()
                    }
                } label: {
                    Text(Date().formatDateFrom(for: todayDateComponent))
                        .padding()
                        .padding(.horizontal)
                        .background(
                            RoundedRectangle(cornerRadius: 30)
                                .stroke(Color.gray)
                        )
                }
                .background(
                    DatePicker("",selection: $todayDateComponent, displayedComponents: .date)
                        .datePickerStyle(.compact)
                        .clipShape(Capsule())
                        .background(Color.gray.cornerRadius(10))
                        .opacity(showDate ? 1 : 0)
                        .offset(y: 50)
                        .zIndex(1)
                        .onChange(of: todayDateComponent, perform: { newValue in
                            DispatchQueue.main.async {
                                withAnimation {
                                    showDate.toggle()
                                    viewModel.fetchItems(for: todayDateComponent)
                                }
                            }
                            
                        })
                )
                
                HStack{
                    CategoryChart(todayDateComponent: $todayDateComponent)
                    
                }
                .padding(.top,50)
                
                NeedsWantsBarChart().frame(height: 180).padding()
                
            }

        }
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView(todayDateComponent: .constant(Date()))
            .environmentObject(coreDataViewModel())
    }
}
