//
//  CoreDataViewModel.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 24/04/23.
//

import Foundation
import CoreData
import UIKit
import SwiftUI
import SwiftUICharts

class coreDataViewModel : ObservableObject{
    let manager = PersistenceController.shared
    @Published var userItems : [ItemEntity] = []
    @Published var itemForBarChart : [ItemEntity] = []
    @Published var userList: [UserEntity] = []
    let categoryFNB = category.FNB.rawValue
    let categoryTransport = category.transport.rawValue
    let categoryBarang = category.barang.rawValue
    let dateFormatter = DateFormatter()
    
    func fetchUser(){
        let request = NSFetchRequest<UserEntity>(entityName: "UserEntity")
        
        withAnimation(Animation.default) {
            do{
                userList = try manager.container.viewContext.fetch(request)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func checkEmptyUsername() -> Bool{
        return userList.isEmpty //(kalo empty -> true, force return
    }
    
    func getName() -> String{
        if (userList.isEmpty) {
            return "empty"
        }
        return userList.first!.username ?? "error"
    }
    
    func addName(name : String){
        let newUser = UserEntity(context: manager.container.viewContext)
        newUser.username = name
        withAnimation(Animation.default) {
            do{
                try manager.container.viewContext.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
        fetchUser()
    }
    
    func fetchItems(for date : Date){
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        dateFormatter.dateFormat = "yyyyMMdd"
        let dateString = dateFormatter.string(from: date)
        let datePredicate = NSPredicate(format : "itemAddedDate == %@", dateString)
        //        let categoryPredicate = NSPredicate(format: "itemCategory == %@", category)
        //        request.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [datePredicate, categoryPredicate])
        request.predicate = datePredicate
        withAnimation(Animation.default) {
            do{
                userItems = try manager.container.viewContext.fetch(request)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
    }
    func getLastSevenDaysData(startFrom date : Date) -> [barChartData]{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let validDates = date.getDatesForLastNDays(startDate: date, nDays: 7)
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let validDatePredicate = NSPredicate(format: "itemAddedDate IN %@", validDates)
        request.predicate = validDatePredicate
        withAnimation(Animation.default){
            do{
                itemForBarChart = try manager.container.viewContext.fetch(request)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
        let containingDates = itemForBarChart.map({$0.itemAddedDate})
        var barChartData : [barChartData] = []
        for validDate in validDates {
            if !containingDates.contains(validDate){
                barChartData.append(.init(day: validDate, expense: 0, tag: "Keinginan"))
                barChartData.append(.init(day: validDate, expense: 0, tag: "Kebutuhan"))
            }
            
        }
        var uniqueDates : [String] = []
        uniqueDates = itemForBarChart.map( {$0.itemAddedDate ?? "" } ).unique.sorted()
        var needsTotalExpense : Double = 0
        var wantsTotalExpense : Double = 0
//        if itemForBarChart.isEmpty{
//            let nilItem = barChartData
//            return barChartData[.init]
//        }
        
        for date in uniqueDates{
            //Fungsi ini COSTLY AF, masi dipikirin cara untuk optimisasi
            let transactionAtDate = itemForBarChart.filter({$0.itemAddedDate == date})
            let needsTransaction = transactionAtDate.filter({$0.itemTag == "Keinginan"})
            needsTotalExpense = needsTransaction.map({$0.itemPrice}).reduce(0, +)
            let wantsTransaction = transactionAtDate.filter({$0.itemTag == "Kebutuhan"})
            wantsTotalExpense = wantsTransaction.map({$0.itemPrice}).reduce(0, +)
            barChartData.append(.init(day: date, expense: needsTotalExpense, tag: "Keinginan"))
            barChartData.append(.init(day: date, expense: wantsTotalExpense, tag: "Kebutuhan"))
            
        }
//        for (index, date) in uniqueDates.enumerated(){
//            let correctDate = Calendar.current.date(byAdding: .day, value: 1, to: date)!
//            uniqueDates[index] = correctDate
//
//        }
        return barChartData
    }
    func getAllDataBarChart(for date : Date) -> [barChartData]{
        var barChartData : [barChartData] = []
        for item in userItems{
            barChartData.append(.init(day: item.itemAddedDate ?? Date().formatDateFrom(for: Date()), expense: item.itemPrice, tag: item.itemTag ?? ""))
        }
        return barChartData
    }
    //    func calculateItemPricePerCategory(for date : Date, category : String) -> Double{
    //        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
    //        let dateString = String(date.get(.year)) + String(date.get(.month)) + String(date.get(.day))
    //        let datePredicate = NSPredicate(format : "itemAddedDate == %@", dateString)
    //        let categoryPredicate = NSPredicate(format: "itemCategory == %@", category)
    //        request.predicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [datePredicate, categoryPredicate])
    //        withAnimation(Animation.default) {
    //            do{
    //                userItems = try manager.container.viewContext.fetch(request)
    //            }
    //            catch let error{
    //                print(error.localizedDescription)
    //            }
    //        }
    //
    //    }
    func calculateItemPriceCategory(category : String) -> Double{
        let selectedCategory = userItems.filter({ $0.itemCategory == category })
        let itemPrice = selectedCategory.map{ $0.itemPrice }
        let totalPrice = itemPrice.reduce(0, +)
        return totalPrice
//        var allPrice: Double = 0
//        for item in userItems {
//            if item.itemCategory == category {
//                allPrice += item.itemPrice
//            }
//        }
//        return allPrice
    }
    
    func calculateAllExpense(for date: Date) -> Double {
        let fnbPrice = calculateItemPriceCategory(category: categoryFNB)
        let transportPrice = calculateItemPriceCategory(category: categoryTransport)
        let barangPrice = calculateItemPriceCategory(category: categoryBarang)
        let allExpense = fnbPrice + transportPrice + barangPrice
        return allExpense
    }
    
    
    func fetchAllItem(){
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        withAnimation(Animation.default) {
            do{
                userItems = try manager.container.viewContext.fetch(request)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
    }
    func addNewItem(date: Date, price : Double, itemName : String, itemDescription : String, itemCategory : String, itemTag : String){
        withAnimation(Animation.default) {
            let newItem = ItemEntity(context: manager.container.viewContext)
//            // if itemImage Binary datatype
//            var itemImage : UIImage = UIImage(systemName: "trash")!
//            switch itemCategory{
//            case categoryFNB:
//                itemImage = UIImage(systemName: "fork.knife")!.withTintColor(UIColor(Color.white))
//            case categoryTransport:
//                itemImage = UIImage(systemName: "tram.fill")!.withTintColor(UIColor(Color.white))
//            case categoryBarang:
//                itemImage = UIImage(systemName: "bag")!.withTintColor(UIColor(Color.white))
//            default:
//                itemImage = UIImage(systemName: "bag")!.withTintColor(UIColor(Color.white))
//            }
//            // ketika di encode background jadi putih
//            let newItemImage = encodeImage(for: itemImage)
            
            var itemImage : String = "trash"
            switch itemCategory{
            case categoryFNB:
                itemImage = "fork.knife"
            case categoryTransport:
                itemImage = "tram.fill"
            case categoryBarang:
                itemImage = "bag"
            default:
                itemImage = "bag"
            }
//            let newItemImage = itemImage
            
            dateFormatter.dateFormat = "yyyyMMdd"
            let newItemDate = dateFormatter.string(from: date)
            newItem.itemId = UUID().uuidString
            newItem.itemAddedDate = newItemDate
            newItem.itemPrice = price
            newItem.itemName = itemName
            newItem.itemDescription = itemDescription
            newItem.itemImage = itemImage
            newItem.itemCategory = itemCategory
            newItem.itemTag = itemTag
            //append
            userItems.append(newItem)
            save()
        }
        
    }
    func deleteItem(for itemId : String){
        withAnimation {
            let itemToBeDeleted = userItems.first(where: {$0.itemId == itemId})
            manager.container.viewContext.delete(itemToBeDeleted!)
            userItems = userItems.filter({$0.itemId != itemId})
            save()
        }
        
    }
    func encodeImage(for selectedImage : UIImage) -> Data {
        let convertedImage = selectedImage.jpegData(compressionQuality: 1.0)
        return convertedImage!
    }
    func save(){
        withAnimation(Animation.default) {
            do{
                try manager.container.viewContext.save()
            }
            catch{
                print(error.localizedDescription)
            }
        }
    }
    public func chartDummyData() -> DoughnutChartData{
        let data = PieDataSet(dataPoints: Array<PieChartDataPoint>(), legendTitle: "")
        
        let metadata   = ChartMetadata(title: "", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .floating,
            infoBoxContentAlignment : .horizontal,
            infoBoxDescriptionFont : .footnote,
            infoBoxBorderColour : Color.primary,
            infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
            globalAnimation     : .easeOut(duration: 1)
        )
        
        return DoughnutChartData(
            dataSets       : data,
            metadata       : metadata,
            chartStyle     : chartStyle,
            noDataText     : Text("No Data")
        )
    }
    
    /// get data for category charts
    public func getChartData(for date: Date) -> DoughnutChartData{
//        fetchItems(for: date)
        let fnbPrice = calculateItemPriceCategory(category: categoryFNB)
        let transportPrice = calculateItemPriceCategory(category: categoryTransport)
        let barangPrice = calculateItemPriceCategory(category: categoryBarang)
        let data = PieDataSet(
            dataPoints: [
                PieChartDataPoint(
                    value: fnbPrice,
                    colour: Color.primary_purple),
                PieChartDataPoint(
                    value: transportPrice,
                    colour: Color.secondary_purple),
                PieChartDataPoint(
                    value: barangPrice,
                    colour: Color.tertiary_purple)
            ],
            legendTitle: "")
        let metadata   = ChartMetadata(title: "", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .floating,
            infoBoxContentAlignment : .horizontal,
            infoBoxDescriptionFont : .footnote,
            infoBoxBorderColour : Color.primary,
            infoBoxBorderStyle  : StrokeStyle(lineWidth: 1),
            globalAnimation     : .easeOut(duration: 1)
        )
        
        return DoughnutChartData(
            dataSets       : data,
            metadata       : metadata,
            chartStyle     : chartStyle,
            noDataText     : Text("No Data")
        )
    }
    public init(){
        fetchItems(for: Date())
    }
}
