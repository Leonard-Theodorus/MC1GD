//
//  CurrencyExtension.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 06/05/23.
//

import Foundation
extension String{
    func stripComma(for str : String) -> Double{
        let cleaned = str.replacingOccurrences(of: ",", with: "")
        return Double(cleaned) ?? 0
    }
}
