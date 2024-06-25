//
//  HelloCard.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct HelloCard: View {
    @Binding var allExpense : Double
    @Binding var userName : String
    var body : some View{
        VStack(alignment: .leading){
            HStack{
                Image(systemName: "sun.min.fill")
                Text("Hai,")
                    .font(.title2)
                    .fontWeight(.light)
                Text(userName)
                    .font(.title2)
                    .fontWeight(.semibold)
                Spacer()
            }
            .padding()
            if (allExpense != 0){
                Text("Pengeluaranmu")
                    .fontWeight(.light)
                    .padding(.horizontal)
                Text(currencyFormatter.string(from: NSNumber(value: allExpense)) ?? "")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.horizontal)
                    .padding(.bottom)
            }
        }
        .padding(.vertical,8)
        .foregroundColor(.white)
        .background(
            ZStack{
                LinearGradient(colors: [Color.secondary_purple, Color.primary_purple], startPoint: .topLeading, endPoint: .bottomTrailing)
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
    }
    
    
}

struct HelloCard_Previews: PreviewProvider {
    static var previews: some View {
        HelloCard(allExpense: .constant(0), userName: .constant("UserName"))
    }
}
