//
//  FormValidationPublishers.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 27/04/23.
//

import SwiftUI
import Combine

class FormViewModel : ObservableObject {
    @Published var textCount : Int = 0
    @Published var itemName = ""
    @Published var textIsValid = false
    @Published var buttonDeleteOn = false
    var cancellables = Set<AnyCancellable>()
    init(){
        itemNameSubsriber()
        deleteButtonSubscriber()
    }
    func deleteText(){
        self.itemName = ""
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
    
}
