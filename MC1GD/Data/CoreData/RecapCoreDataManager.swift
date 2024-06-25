//
//  RecapCoreDataManager.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation
import CoreData
import SwiftUICharts
import SwiftUI

class RecapCoreDataManager {
    static let `default` = RecapCoreDataManager()
    private let container = PersistenceController.shared
    private init() {}
    
    func fetchChartData(date : Date, displayRange : ChartDisplayRange) -> ((DoughnutChartData, [BarchartData], ExpenseDetail)){
        var expenseItems : [ItemEntity] = []
        var barChartDataset : [BarchartData] = []
        if displayRange == .day{
            let date = Date().formatExpenseDate(for: date)
            let fetchRequest = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
            let datePredicate = NSPredicate(format : "itemAddedDate == %@", date)
            fetchRequest.predicate = datePredicate
            do{
                try expenseItems = container.container.viewContext.fetch(fetchRequest)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
        else{
            let validDates = Date().getDatesForLastNDays(startDate: date, nDays: 8)
            let fetchRequest = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
            let datePredicate = NSPredicate(format : "itemAddedDate IN %@", validDates)
            fetchRequest.predicate = datePredicate
            do{
                try expenseItems = container.container.viewContext.fetch(fetchRequest)
            }
            catch let error{
                print(error.localizedDescription)
            }
            let containingDates = expenseItems.map{$0.itemAddedDate}
            for validDate in validDates {
                if !containingDates.contains(validDate){
                    barChartDataset.append(.init(day: validDate, expense: 0, tag: "Keinginan"))
                    barChartDataset.append(.init(day: validDate, expense: 0, tag: "Kebutuhan"))
                }
                else{
                    let transactionAtDate = expenseItems.filter{$0.itemAddedDate == validDate}
                    let needsTotalExpense = transactionAtDate.filter{$0.itemTag == "Kebutuhan"}
                        .map{$0.itemPrice}
                        .reduce(0, +)
                    let wantsTotalExpense = transactionAtDate.filter{$0.itemTag == "Keinginan"}
                        .map{$0.itemPrice}
                        .reduce(0, +)
                    
                    barChartDataset.append(.init(day: validDate, expense: needsTotalExpense, tag: "Keinginan"))
                    barChartDataset.append(.init(day: validDate, expense: wantsTotalExpense, tag: "Kebutuhan"))
                    
                }
            }
            
        }
        
        var datasets : [PieChartDataPoint] = []
        let metadata   = ChartMetadata(title: "", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .floating,
            infoBoxContentAlignment : .horizontal,
            infoBoxDescriptionFont : .footnote,
            infoBoxBorderColour : Color.primary,
            infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
            globalAnimation     : .easeOut(duration: 1)
        )
        let fnbExpense = expenseItems.filter{$0.itemCategory == ExpenseCategory.fnb.rawValue}
            .map{$0.itemPrice}
            .reduce(0, +)
        let transportExpense = expenseItems.filter{$0.itemCategory == ExpenseCategory.transport.rawValue}
            .map{$0.itemPrice}
            .reduce(0, +)
        let itemsExpense = expenseItems.filter{$0.itemCategory == ExpenseCategory.item.rawValue}
            .map{$0.itemPrice}
            .reduce(0, +)
        
        datasets.append(PieChartDataPoint(value: fnbExpense, colour: Color.primary_purple))
        datasets.append(PieChartDataPoint(value: transportExpense, colour: Color.secondary_purple))
        datasets.append(PieChartDataPoint(value: itemsExpense,  colour: Color.tertiary_purple))
        
        let doughnutChartDataset = PieDataSet(dataPoints: datasets, legendTitle: "")
        let doughnutChartData =  DoughnutChartData(
            dataSets       : doughnutChartDataset,
            metadata       : metadata,
            chartStyle     : chartStyle,
            noDataText     : Text("No Expense")
        )
        let totalExpense = expenseItems.map{$0.itemPrice}.reduce(0, +)
        let totalWantsExpense = expenseItems.filter{$0.itemTag == "Keinginan"}.map{$0.itemPrice}.reduce(0, +)
        let totalNeedsExpense = expenseItems.filter{$0.itemTag == "Kebutuhan"}.map{$0.itemPrice}.reduce(0, +)
        
        let expenseDetail = ExpenseDetail(total: totalExpense, wantsTotal: totalWantsExpense, needsTotal: totalNeedsExpense)
        return (doughnutChartData, barChartDataset, expenseDetail)
        
    }
}
