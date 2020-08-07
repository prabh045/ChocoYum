
//  Created by Prabhdeep Singh on 06/08/20.
//  Copyright © 2020 Prabh. All rights reserved.


import Foundation

enum CurrencyFormatter {
  static let dollarsFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.currencyCode = "USD"
    return formatter
  }()
}

extension NumberFormatter {
  ///Convenience method to prevent having to cast floats to NSNumbers every single time.
  func string(from float: Float) -> String? {
    return string(from: NSNumber(value: float))
  }
}
