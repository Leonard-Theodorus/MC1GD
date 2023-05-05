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
            GeometryReader { geometry in
                HStack{
                    if needsPercentage.isNaN{
                        Text("0%")
                    }else{
                        Text(String(Int(round(needsPercentage * 100))) + "%")
                    }
                    Spacer()
                    if needsPercentage.isNaN{
                        Text("0%")
                    }else{
                        Text(String(Int(round(wantsPercentage * 100))) + "%")
                    }
                }
                .foregroundColor(Color.white)
                .font(.caption2)
                .fontWeight(.bold)
                .zIndex(2)
                .frame(height: 30)
                .padding(.horizontal)
                
                ZStack(alignment: .leading) {
                    //                    Text("0%")
                    //                        .foregroundColor(.black)
                    //                        .frame(width: geometry.size.width, height: geometry.size.height)
                    Rectangle().frame(width: geometry.size.width , height: geometry.size.height)
                        .foregroundColor(Color.tag_pink)
                    
                    Rectangle().frame(width: abs(geometry.size.width * (needsPercentage)), height: geometry.size.height)
                        .foregroundColor(Color.tag_purple)
                }
                .cornerRadius(45.0)
            }
        }
        .frame(height: 30)
        
        HStack{
            Text("Kebutuhan")
            Spacer()
            Text("Keinginan")
        }
        .font(.caption)
        .fontWeight(.bold)
        .italic()
        .foregroundColor(Color.secondary_gray)
    }
}

struct HorizontalProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalProgressBar(needsPercentage: .constant(50), wantsPercentage: .constant(50))
    }
}
