//
//  TabBarButton.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct TabBarButton: View {
    var buttonText: String
    var imageName: String
    var isActive: Bool
    
    var body: some View {
        GeometryReader{ geo in
            VStack(alignment: .center, spacing: 2){
                Spacer()
                if imageName == "rupiah"{
                    Text("Rp")
                        .font(.system(size: 24))
                }else{
                    Image(systemName: imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                Text(buttonText)
                    .font(.callout)
            }
            .tint(isActive ? Color.primary_purple : Color.secondary_gray)
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Summary", imageName: "creditcard.circle", isActive: true)
    }
}
