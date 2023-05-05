//
//  FormValidationPublishers.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 27/04/23.
//

import SwiftUI
import Combine

class addItemFormViewModel : ObservableObject{
    @Published var textCount : Int = 0
    @Published var itemPrice : Double = 0
    @Published var priceValue : Double = 0
    @Published var priceIsValid = false
    @Published var priceButtonDeleteOn = false
    @Published var itemName = ""
    @Published var textIsValid = false
    
    @Published var buttonDeleteOn = false
   
    
    var cancellables = Set<AnyCancellable>()
    init(){
        itemNameSubsriber()
        deleteButtonSubscriber()
        itemPriceSubscriber()
        deleteButtonPriceSubscriber()
    }
    func deleteText(){
        self.itemName = ""
    }
    func deletePrice(){
        self.itemPrice = 0
    }
    func itemNameSubsriber(){
        $itemName.map{ (text) -> Bool in
            if text.first == " " || text.last == " "{
                return false
            }
            else if text.count == 0{
                return false
            }
            self.textCount += 1
            return true
        }
        .sink(receiveValue: {[weak self] isValid in
            withAnimation {
                self?.textIsValid = isValid
            }
        })
        .store(in: &cancellables)
    }
    func deleteButtonSubscriber(){
        $textIsValid.combineLatest($textCount)
            .sink { [weak self] (isValid, count) in
                guard let self else {return}
                if isValid && count >= 1{
                    self.buttonDeleteOn = true
                }
                else{
                    self.buttonDeleteOn = false
                }
            }
            .store(in: &cancellables)
    }
    func itemPriceSubscriber(){
        $itemPrice.map{ (price) -> Bool in
            if price == 0{
                return false
            }
            self.priceValue = price
            return true
        }
        .sink { [weak self] isValid in
            withAnimation {
                self?.priceIsValid = isValid
            }
        }
        .store(in: &cancellables)
    }
    func deleteButtonPriceSubscriber(){
        $priceIsValid.combineLatest($priceValue)
            .sink { [weak self] (isValid, newPrice) in
                guard let self else {return}
                if isValid && newPrice != 0{
                    self.priceButtonDeleteOn = true
                }
                else{
                    self.priceButtonDeleteOn = false
                }
            }
            .store(in: &cancellables)
    }
    
}
