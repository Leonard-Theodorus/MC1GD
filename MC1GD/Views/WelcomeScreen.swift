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
    
    var body: some View {
        VStack{
            Spacer()
            TextField("Ketik Namamu", text: $nicknameUser).disableAutocorrection(true)
                .padding()
                .background(.white)
                .cornerRadius(12)
                .padding(.horizontal,37)
                .foregroundColor(.black)
            Button{
                viewModel.addName(name: nicknameUser)
            }label: {
                Text("Mulai Perjalananmu")
                    .padding()
                    .background(Color("primary-purple"))
                    .cornerRadius(32)
                    .shadow(color: .black, radius: 4, x: 0, y:4)
                    .padding(.top,10)
            }
            
            Spacer()
        }
        .background(
            LinearGradient(colors: [Color("secondary-purple"),Color("primary-purple")], startPoint: .topLeading, endPoint: .bottomTrailing))
        .foregroundColor(Color("primary-white"))
    }
}

struct WelcomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
            .environmentObject(coreDataViewModel())
    }
}
