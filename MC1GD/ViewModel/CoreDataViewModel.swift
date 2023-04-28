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
    @Published var categoryFNB = "Makanan dan Minuman"
    @Published var categoryTransport = "Transportasi"
    @Published var categoryBarang = "Barang"
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
    func calculateItemPriceCategory(for date : Date, category : String) -> Double{
        var allPrice: Double = 0
        for item in userItems {
            if item.itemCategory == category {
                allPrice += item.itemPrice
            }
        }
        return allPrice
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
    init(){
        fetchItems(for: Date())
    }
}
