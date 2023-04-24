//
//  DateModel.swift
//  MC1
//
//  Created by Leonard Theodorus on 24/04/23.
//

import Foundation

extension Date{
    func formatDate() -> String {
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        return String(day) + " " + month
    }
    func formatDateFrom(for date : Date) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        return String(day) + " " + month
    }
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}

