//
//  SavingsCoreDataManager.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation
import CoreData

class SavingsCoreDataManager {
    static let `default` = SavingsCoreDataManager()
    private let container = PersistenceController.shared
    private init () {}
    
    func writeSavingData(savings : UserSaving){
        let newSavingEntity = SavingEntity(context: container.container.viewContext)
        newSavingEntity.savingId = savings.id
        newSavingEntity.savingAmount = savings.savingAmount
        newSavingEntity.savingDate = savings.dateAdded
        saveDbState()
    }
    
    func fetchSavings() -> ([UserSavingDTO], Double){
        let fetchRequest = NSFetchRequest<SavingEntity>(entityName: "SavingEntity")
        var userSavingsFromDb : [SavingEntity] = []
        var userSavingsDto : [UserSavingDTO] = []
        var totalSavings : Double = 0
        do{
            userSavingsFromDb = try container.container.viewContext.fetch(fetchRequest)
        }
        catch let err{
            print(err.localizedDescription)
        }
        for saving in userSavingsFromDb {
            guard let newSavingDto = UserSavingDTO(from: saving) else {continue}
            userSavingsDto.append(newSavingDto)
            totalSavings += newSavingDto.savingAmount
        }
        return (userSavingsDto, totalSavings)
    }
    
    private func saveDbState(){
        do{
            try container.container.viewContext.save()
        }
        catch{
            print(error.localizedDescription)
        }
    }
}
