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
    let categoryFNB = category.FNB.rawValue
    let categoryTransport = category.transport.rawValue
    let categoryBarang = category.barang.rawValue
    func tryAppending(request : NSFetchRequest<ItemEntity>){
        withAnimation(Animation.default) {
            do{
                userItems = try manager.container.viewContext.fetch(request)
            }
            catch let error{
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchItems(for date : Date){
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        let dateString = String(date.get(.year)) + String(date.get(.month)) + String(date.get(.day))
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
    func addNewItem(itemImage : UIImage = UIImage(systemName: "trash")!, date: Date, price : Double, itemName : String, itemDescription : String, itemCategory : String, itemTag : String){
        withAnimation(Animation.default) {
            let newItem = ItemEntity(context: manager.container.viewContext)
            let newItemImage = encodeImage(for: itemImage)
            let newItemDate = String(date.get(.year)) + String(date.get(.month)) + String(date.get(.day))
            newItem.itemId = UUID().uuidString
            newItem.itemAddedDate = newItemDate
            newItem.itemPrice = price
            newItem.itemName = itemName
            newItem.itemDescription = itemDescription
            newItem.itemImage = newItemImage
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
    public func getChartData(for date: Date) -> DoughnutChartData{
//        fetchItems(for: date)
        let fnbPrice = calculateItemPriceCategory(category: categoryFNB)
        let transportPrice = calculateItemPriceCategory(category: categoryTransport)
        let barangPrice = calculateItemPriceCategory(category: categoryBarang)
        let data = PieDataSet(
            dataPoints: [
                PieChartDataPoint(value: fnbPrice, description: "Makanan & Minuman", colour: Color(.orange), label: .label(text: "Makanan & Minuman", colour: .black)),
                PieChartDataPoint(
                    value: transportPrice,
                    description: "Transportasi",
                    colour: .purple,
                    label: .label(text: "Transportasi", colour: .black)),
                PieChartDataPoint(
                    value: barangPrice,
                    description: "Barang",
                    colour: .yellow,
                    label: .label(text: "Barang", colour: .black))
            ],
            legendTitle: "Expenses")
        let metadata   = ChartMetadata(title: "Expenses", subtitle: "")
        
        let chartStyle = DoughnutChartStyle(
            infoBoxPlacement : .infoBox(isStatic: false),
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
