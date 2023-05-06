//
//  itemCategoryPicker.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct itemCategoryPicker: View {
    @Binding var newItemCategory : String
    private let categories = ["Makanan dan Minuman", "Transportasi", "Barang"]
    var body: some View {
        HStack{
            Image(systemName: "circle.fill")
                .imageScale(.large)
                .foregroundColor(Color.primary_gray)
                .padding(.horizontal,15)
            HStack {
                Picker("", selection: $newItemCategory) {
                    ForEach(categories, id: \.self){ category in
                        Text(category)
                    }
                }
                .pickerStyle(.menu)
                .tint(Color.primary)
                .clipped()
            }
        }.padding(.vertical, 5)
        Divider()
    }
}

struct itemCategoryPicker_Previews: PreviewProvider {
    static var previews: some View {
        itemCategoryPicker(newItemCategory: .constant(""))
    }
}
