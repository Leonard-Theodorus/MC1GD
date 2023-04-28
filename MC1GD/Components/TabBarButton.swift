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
            if isActive {
                Rectangle()
                    .foregroundColor(.green)
                    .frame(width: geo.size.width, height: 5)
            }
            VStack(alignment: .center, spacing: 2){
                
                Image(systemName: imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 36, height: 36)
                Text(buttonText)
            }
            .frame(width: geo.size.width, height: geo.size.height)
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        TabBarButton(buttonText: "Summary", imageName: "book.fill", isActive: true)
    }
}
