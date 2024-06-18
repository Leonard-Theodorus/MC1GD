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
                Text("Pilih opsi \"Per 7 Hari\" untuk menampilkan data tujuh hari kebelakang")
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .italic()
                    .foregroundColor(.secondary_gray)
                    .frame(minWidth: 200)
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
