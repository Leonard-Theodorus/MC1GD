//
//  FormValidationPublishers.swift
//  MC1GD
//
//  Created by Leonard Theodorus on 27/04/23.
//

import SwiftUI
import Combine

class addItemFormViewModel : ObservableObject{
    @Published var itemName = ""
    @Published var textIsValid = false
    var cancellables = Set<AnyCancellable>()
    init(){
        itemNameSubsriber()
    }
    func itemNameSubsriber(){
        $itemName.map{ (text) -> Bool in
            if text.first == " " || text.last == " "{
                return false
            }
            else if text.count == 0{
                return false
            }
            return true
        }
        .sink(receiveValue: {[weak self] isValid in
            withAnimation {
                self?.textIsValid = isValid
            }
        })
        .store(in: &cancellables)
    }
}
