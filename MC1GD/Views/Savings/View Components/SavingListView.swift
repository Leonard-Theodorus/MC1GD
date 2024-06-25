//
//  SavingListView.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import SwiftUI

struct SavingListView : View {
    
    @Binding var userSavings : [UserSaving]
    
    var body: some View {
        List{
            ForEach(userSavings.reversed()) { saving in
                VStack{
                    HStack(alignment: .top){
                        VStack(alignment: .leading){
                            Text(saving.dateAdded)
                                .font(.headline)
                                .padding(.bottom,-5)
                        }
                        Spacer()
                        Text("+ \(currencyFormatter.string(from: NSNumber(value: saving.savingAmount)) ?? "")")
                            .foregroundColor(Color.primary_green)
                            .fontWeight(.bold)
                    }
                    .padding(.horizontal,3)
                    .padding(.vertical)
                }
            }
            .listRowInsets(EdgeInsets())
        }
        .padding()
        .padding(.top,3)
        .background(.white)
        .cornerRadius(22)
        .listStyle(.plain)
        .clipped()
        .shadow(color: Color.gray, radius: 4, y: 2)
        .padding(.top)
    }
}
