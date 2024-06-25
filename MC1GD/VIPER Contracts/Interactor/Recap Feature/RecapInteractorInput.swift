//
//  RecapInteractorInput.swift
//  MC1GD
//
//  Created by Alonica🐦‍⬛🐺 on 24/06/24.
//

import Foundation

protocol RecapInteractorInput : AnyObject{
    var output : RecapInteractorOutput? {get set}
    var dataRepository : RecapDataRepository {get set}
    
    func fetchChartDataFromRepo(for date : Date, displayRange : ChartDisplayRange)
}
