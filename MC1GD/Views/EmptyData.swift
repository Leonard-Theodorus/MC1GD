//
//  EmptyData.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 05/05/23.
//

import SwiftUI

struct EmptyData: View {
    var desc : String
    
    var body: some View {
        HStack{
            Spacer()
            VStack{
                Spacer()
                Image(systemName: "ellipsis")
                    .resizable()
                    .frame(width: 60, height: 14)
                Text(desc)
                    .font(.title3)
                Spacer()
            }
            Spacer()
        }
    }
}

struct EmptyData_Previews: PreviewProvider {
    static var previews: some View {
        EmptyData(desc: "Belum ada pengeluaran")
    }
}
