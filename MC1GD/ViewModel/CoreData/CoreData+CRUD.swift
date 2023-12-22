//
//  CoreData+CRUD.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 22/12/23.
//

import Foundation
import CoreData

extension coreDataViewModel{
    func fetchExpenseForId(id : String) -> ItemEntity?{
        let predicate = NSPredicate(format: "itemId == %@", id)
        let request = NSFetchRequest<ItemEntity>(entityName: "ItemEntity")
        request.predicate = predicate
        var item : [ItemEntity] = []
        do{
            item = try manager.container.viewContext.fetch(request)
        }
        catch{
            print(error.localizedDescription)
        }
        if !item.isEmpty{
            guard let first = item.first else {return nil }
            let index = userItems.firstIndex { entity in
                entity.itemId == first.itemId
            }
            guard let index else {return nil}
            userItems.remove(at: index)
            return first
        }
        else{
            return nil
        }
        
    }
    
    
    func editExpense(itemId : String, newDate : Date, newPrice : String, newName : String, newDescription : String, newCategory : String, newItemTag : String){
        //Fetch with id
        let matchingRecord = fetchExpenseForId(id: itemId)
        guard let matchingRecord else {return}
        //ganti property
        dateFormatter.dateFormat = "yyyyMMdd"
        let newItemDate = dateFormatter.string(from: newDate)
        DispatchQueue.main.async {
            matchingRecord.itemAddedDate = newItemDate
            matchingRecord.itemPrice = newPrice.stripComma(for: newPrice)
            matchingRecord.itemTag = newItemTag
            matchingRecord.itemCategory = newCategory
            matchingRecord.itemDescription = newDescription
            matchingRecord.itemName = newName
            switch newCategory{
                case self.categoryFNB:
                    matchingRecord.itemImage = "fork.knife"
                case self.categoryTransport:
                    matchingRecord.itemImage = "tram.fill"
                case self.categoryBarang:
                    matchingRecord.itemImage = "bag"
                default:
                    matchingRecord.itemImage = "bag"
            }
            self.save()
            self.fetchItems(for: newDate)
        }
        //save
    }
}
