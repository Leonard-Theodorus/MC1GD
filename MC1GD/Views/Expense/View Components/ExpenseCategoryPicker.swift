//
//  itemCategoryPicker.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import SwiftUI

struct ExpenseCategoryPicker: View {
    @Binding var newItemCategory : ExpenseCategory
    private let categories = ["Makanan dan Minuman", "Transportasi", "Barang"]
    var body: some View {
        HStack{
            Image(systemName: "circle.fill")
                .imageScale(.large)
                .foregroundColor(Color.primary_gray)
                .padding(.horizontal,15)
            HStack {
                Picker("", selection: $newItemCategory) {
                    ForEach(ExpenseCategory.allCases, id: \.self){ category in
                        Text(category.rawValue)
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
        ExpenseCategoryPicker(newItemCategory: .constant(.fnb))
    }
}
