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
    func dateStepBackward () -> String {
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        guard day != 1 else {return ""}
        return String(day - 1) + " " + month
    }
    func dateStepForward () -> String {
        let date = Date()
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "LLLL"
        let day = calendar.component(.day, from: date)
        let month = dateFormatter.string(from: date)
        guard day != 31 else {return ""}
        return String(day + 1) + " " + month
    }
}

