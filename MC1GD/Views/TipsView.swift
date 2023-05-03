//
//  TipsView.swift
//  MC1GD
//
//  Created by Sarah Uli Octavia on 03/05/23.
//

import SwiftUI

struct TipsView: View {
    @Binding var showTips: Bool
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TipsView_Previews: PreviewProvider {
    static var previews: some View {
        TipsView(showTips: .constant(false))
    }
}
