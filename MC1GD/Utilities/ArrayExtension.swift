//
//  ArrayExtension.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 01/05/23.
//

import Foundation
extension Array where Element: Equatable {
    var unique: [Element] {
        var uniqueValues: [Element] = []
        forEach { item in
            guard !uniqueValues.contains(item) else { return }
            uniqueValues.append(item)
        }
        return uniqueValues
    }
}
