//
//  CurrencyFormatter.swift
//  MC1
//
//

import SwiftUI
import Foundation

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "Rp"
    formatter.maximumFractionDigits = 0
    formatter.decimalSeparator = "."
    formatter.groupingSeparator = ","
    formatter.zeroSymbol = ""
    return formatter
}()
let currencyFormatterInForm: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.currencySymbol = ""
    formatter.maximumFractionDigits = 0
    formatter.groupingSeparator = ","
    formatter.zeroSymbol = ""
    return formatter
}()
