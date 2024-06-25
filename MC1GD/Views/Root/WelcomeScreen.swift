//
//  WelcomeScreen.swift
//  MC1GD
//
//  Created by beni garcia on 02/05/23.
//

import SwiftUI

struct WelcomeScreen: View {
    @State var newUsername = ""
    @FocusState var focusName: Bool
    @State var showDelete : Bool = false
    @State var presenter : UserCredentialsPresenter
    
    var body: some View {
        VStack{
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 150,height: 150, alignment: .center)
                .padding()
                .padding(.vertical,50)
            HStack {
                ZStack {
                    TextField("Ketik Namamu", text: $newUsername).disableAutocorrection(true)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.horizontal,37)
                        .foregroundColor(.black)
                    if newUsername != "" {
                        Button{
                            newUsername = ""
                            showDelete.toggle()
                        }label: {
                            HStack{
                                Spacer()
                                Image(systemName: "x.circle.fill")
                                    .foregroundColor(.secondary_gray)
                            }
                            .padding(.horizontal,57)
                        }
                    }
                    
                }
            }
            
            Button{
                presenter.writeUserCredentials(username: newUsername)
            }label: {
                Text("Mulai Perjalananmu")
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .font(.callout)
                    .foregroundColor(newUsername != "" ? Color.primary_white : Color.secondary_gray)
                    .background(newUsername != "" ? Color.secondary_purple : Color.primary_white)
                    .cornerRadius(32)
                    .shadow(radius: 4, y:2)
                    .padding(.top,10)
            }.disabled(newUsername == "")
            
            Spacer()
            
            
        }
        .background(
            ZStack{
                LinearGradient(colors: [Color("secondary-purple"),Color("primary-purple")], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                HStack(alignment:.bottom){
                    VStack{
                        Spacer()
                        Image("beruang-welcome")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 380)
                            .padding(.bottom,-50)
                    }
                }
            }
            
            
        )
        
        .foregroundColor(Color("primary-white"))
    }
}

//struct WelcomeScreen_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeScreen()
//    }
//}
