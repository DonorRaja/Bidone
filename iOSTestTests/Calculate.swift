//
//  Calculate.swift
//  iOSTestTests
//
//  Created by DonorRaja on 28/03/22.
//

import UIKit
@testable import iOSTest

class Calculate: XCTestCase {
    
    
    func currencyFormatCheck() throws {
        let currncy = Utility.makeCurrencyFormatter(currentAmount: 566.98765)
        print(currncy)
        XCTAssertEqual( "$566.99", currncy)
    }

}
