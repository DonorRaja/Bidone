//
//  Utility.swift
//  iOSTest
//
//  Created by DonorRaja on 28/03/22.
//

import Foundation

class Utility: NSObject {

//MARK: - calculateGST
class func calculateGST(excludeGST: Double,percentage: Double) -> Double {
    
    let gstAmount = (excludeGST*percentage)/100
    
    return gstAmount
}

//MARK: - makeCurrencyFormatter
class func makeCurrencyFormatter(currentAmount: Double) -> String {
    
    let currencyFormatter = NumberFormatter()
    currencyFormatter.locale = Locale.current
    currencyFormatter.usesGroupingSeparator = true
    currencyFormatter.numberStyle = NumberFormatter.Style.currency
    
    return currencyFormatter.string(from: NSNumber(value: currentAmount))!
}
    // MARK: - grouping Dictionary
    class func groupingDictionary(dict:[Order])-> [String: [Order]] {
        
        let groupedDict = Dictionary(grouping: dict, by: { $0.orderDate })
        return groupedDict
    }
    
}
