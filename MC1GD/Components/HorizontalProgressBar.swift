//
//  HorizontalProgressBar.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 02/05/23.
//

import SwiftUI

struct HorizontalProgressBar: View {
    @Binding var needsPercentage : Double
    @Binding var wantsPercentage : Double
    @State var wantsText : String = ""
    @State var needsText : String = ""
    var body: some View {
        VStack{
            HStack(spacing: 0){
                VStack(alignment: .leading){
                    Text(String(Int(round(needsPercentage * 100))) + "%")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .frame(width: abs((UIScreen.main.bounds.width * needsPercentage) - 40))
                .background(Color.tag_purple)
                VStack(alignment : .trailing){
                    Text(String(Int(round(wantsPercentage * 100))) + "%")
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .foregroundColor(.white)
                }
                .frame(width: abs((UIScreen.main.bounds.width * wantsPercentage) - 40))
                .background(Color.tag_pink)
                
                
            }
            .mask{
                RoundedRectangle(cornerRadius: 20)
            }
            .shadow(radius: 4, y: 8)
            HStack{
                Text("Kebutuhan")
                    .font(.caption)
                    .padding(.leading, 50)
                Spacer()
                Text("Keinginan")
                    .font(.caption)
                    .padding(.trailing, 50)
            }
            
            .foregroundColor(.primary_gray)
        }
        
        
        
    }
}

struct HorizontalProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressBar(needsPercentage: .constant(50), wantsPercentage: .constant(50))
    }
}
