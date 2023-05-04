//
//  Home.swift
//  YT
//
//  Created by Jeremy Christopher on 04/05/23.
//

import SwiftUI
import WebKit

struct Home: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20){
                ScrollView{
                    ZStack{
                        YTView(ID: "62FZ-992ARU")
                        VStack(alignment: .leading, spacing: 5){
                            Text("5 Tips Menabung Untuk Anak")
                                .padding(.trailing, 60)
                            Text("12.34")
    //                            .padding(.trailing, 40)
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350)
                        .padding([.top, .bottom], 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 103/255, green: 64/255, blue: 154/255), Color(red: 139/255, green: 96/255, blue: 186/255)]), startPoint: .leading, endPoint: .trailing)

                        )
                        .padding(.top, 200)
                        .cornerRadius(/*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    }
                    
                    ZStack{
                        YTView(ID: "45p4dPnHSJU")
                        VStack(alignment: .leading, spacing: 5){
                            Text("5 Tips Menabung Untuk Anak")
                                .padding(.trailing, 60)
                            Text("12.34")
    //                            .padding(.trailing, 40)
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350)
                        .padding([.top, .bottom], 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 103/255, green: 64/255, blue: 154/255), Color(red: 139/255, green: 96/255, blue: 186/255)]), startPoint: .leading, endPoint: .trailing)

                        )
                        .padding(.top, 200)
                        .cornerRadius(/*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    }
                    
                    ZStack{
                        YTView(ID: "EJCAsHcS34g")
                        VStack(alignment: .leading, spacing: 5){
                            Text("5 Tips Menabung Untuk Anak")
                                .padding(.trailing, 60)
                            Text("12.34")
    //                            .padding(.trailing, 40)
                        }
                        .foregroundColor(.white)
                        .bold()
                        .frame(width: 350)
                        .padding([.top, .bottom], 10)
                        .background(
                            LinearGradient(gradient: Gradient(colors: [Color(red: 103/255, green: 64/255, blue: 154/255), Color(red: 139/255, green: 96/255, blue: 186/255)]), startPoint: .leading, endPoint: .trailing)

                        )
                        .padding(.top, 200)
                        .cornerRadius(/*@START_MENU_TOKEN@*/14.0/*@END_MENU_TOKEN@*/)
                    }
                    
                }
                
            }
            .navigationTitle("TIPS")
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

