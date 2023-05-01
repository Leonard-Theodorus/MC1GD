//
//  BarChartDataModel.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 30/04/23.
//

import Foundation

struct barChartData : Identifiable{
    let id = UUID()
    let date : Date
    let expense : Double
    let tag : String
    
    init(day : String, expense : Double, tag : String){
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        self.date = formatter.date(from: day) ?? Date.distantPast
        
        self.expense = expense
        self.tag = tag
    }
}
