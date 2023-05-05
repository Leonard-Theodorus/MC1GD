//
//  WelcomeScreen.swift
//  MC1GD
//
//  Created by beni garcia on 02/05/23.
//

import SwiftUI

struct WelcomeScreen: View {
    @State var nicknameUser = ""
    @EnvironmentObject var viewModel : coreDataViewModel
    @FocusState var focusName: Bool
    @State var showDelete : Bool = false
    
    var body: some View {
        VStack{
            Spacer()
            HStack {
                ZStack {
                    TextField("Ketik Namamu", text: $nicknameUser).disableAutocorrection(true)
                        .padding()
                        .background(.white)
                        .cornerRadius(12)
                        .padding(.horizontal,37)
                    .foregroundColor(.black)
                    if nicknameUser != "" {
                        Button{
                            nicknameUser = ""
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
                viewModel.addName(name: nicknameUser)
            }label: {
                Text("Mulai Perjalananmu")
                    .padding(.vertical)
                    .padding(.horizontal, 30)
                    .font(.callout)
                    .foregroundColor(nicknameUser != "" ? Color.primary_white : Color.secondary_gray)
                    .background(nicknameUser != "" ? Color.secondary_purple : Color.primary_white)
                    .cornerRadius(32)
                    .shadow(radius: 4, y:2)
                    .padding(.top,10)
            }.disabled(nicknameUser == "")
            
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

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(coreDataViewModel())
    }
}
