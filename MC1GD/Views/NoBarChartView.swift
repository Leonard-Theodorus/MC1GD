//
//  NoBarChartView.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 03/05/23.
//

import SwiftUI

struct NoBarChartView: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Spacer()
                Text("Pilih opsi tujuh hari kebelakang untuk menampilkan data")
                    .font(.body)
                    .italic()
                    .foregroundColor(.secondary_gray)
                    .padding()
                Spacer()
            }
        }
        .frame(maxHeight: 250)
        .padding()
        .background(Color(.white))
        .cornerRadius(20)
        .shadow(radius: 4, y:2)
    }
}

struct NoBarChartView_Previews: PreviewProvider {
    static var previews: some View {
        NoBarChartView()
    }
}
