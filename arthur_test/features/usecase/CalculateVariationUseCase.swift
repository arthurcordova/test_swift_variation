//
//  CalculateVariationUseCase.swift
//  arthur_test
//
//  Created by Arthur Stapassoli on 13/03/23.
//

import Foundation

protocol CalculateVariationUseCase {
    
    func execute(items: [Double?]) -> [VariationItem]
    
}

class CalculateVariationUseCaseImpl: CalculateVariationUseCase {
    
    func execute(items: [Double?]) -> [VariationItem] {
        var finalItems = [VariationItem]()
        var dayOnePrice = 0.0
        items.enumerated().forEach( { (index,item) in
            let currentPrice = item ?? 0
            if index == 0 {
                dayOnePrice = currentPrice
                finalItems.append(VariationItem(price: currentPrice, variationD1: 0, variationDayOne: 0, day: index))
                return
            }
            if index >= 30 {
                return
            }
            let d1Price = items[index - 1] ?? 0
            let percentaceD1 = ((currentPrice - d1Price) / d1Price) * 100;
            let percentaceDayOne =
                    ((currentPrice - dayOnePrice) / dayOnePrice) * 100
            
            finalItems.append(VariationItem(price: currentPrice, variationD1: percentaceD1, variationDayOne: percentaceDayOne, day: index))
        })
        return finalItems
    }
    
}
