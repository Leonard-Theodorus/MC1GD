
import SwiftUI

//extension Double{
//    func rupiahFormat() -> String {
//        let rp = "Rp. "
//        let formatter = NumberFormatter()
//        formatter.numberStyle = .currency
//
//    }
//}
let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencySymbol = "Rp"
    formatter.maximumFractionDigits = 0
    formatter.decimalSeparator = "."
    formatter.groupingSeparator = ","
    return formatter
}()


