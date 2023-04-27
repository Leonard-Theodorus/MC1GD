//
//  SummaryView.swift
//  MC1GD
//
//  Created by beni garcia on 26/04/23.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        VStack(alignment: .center){
            Text("Ringkasan")
                .foregroundColor(.green)
                .font(.title)
                .bold()
            
            Button{
                //ganti date
            } label: {
                Text("Bulanan")
                    .foregroundColor(.black)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 10)
                    .background(.white)
                    .shadow(radius: 10)
                    .clipShape(Capsule())
                    .shadow(color: Color.gray.opacity(0.5), radius: 10, x: 0, y: 5)
                    
            }
            
            
            
        }
        
    }
}

struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        SummaryView()
    }
}
