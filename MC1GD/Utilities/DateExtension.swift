//
//  DateModel.swift
//  MC1
//
//  Created by Leonard Theodorus on 24/04/23.
//

import Foundation

extension Date{
    func formatDateFrom(for date : Date) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        dateFormatter.locale = Locale(identifier: "ID")
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        var cropedMonth :String = ""
        if month.count > 5 {
            cropedMonth = String(month.prefix(3))
            return String(day) + " " + cropedMonth
        }else{
            return String(day) + " " + month
        }
    }
    
    func formatExpenseDate(for date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let expenseDate = dateFormatter.string(from: date)
        return expenseDate
    }
    
    func formateSavingsDate(for date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMMM yyyy"
        let savingsDate = dateFormatter.string(from: date)
        return savingsDate
    }
    
    func formatDateFull(for date : Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        dateFormatter.locale = Locale(identifier: "ID")
        let dateFormatted = dateFormatter.string(from: date)
        return dateFormatted
    }
    
    func getDatesForLastNDays(startDate : Date ,nDays : Int) -> [String]{
        let cal = NSCalendar.current
        var date = Calendar.current.date(byAdding: .day, value: 1, to: startDate)!
        var arrDates = [String]()
        for _ in 1 ... nDays{
            date = cal.date(byAdding: Calendar.Component.day, value: -1, to: date)!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            dateFormatter.locale = Locale(identifier: "ID")
            let dateString = dateFormatter.string(from: date)
            arrDates.append(dateString)
        }
        return arrDates
    }
}

