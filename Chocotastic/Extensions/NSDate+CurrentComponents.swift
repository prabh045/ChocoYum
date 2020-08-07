
//  Created by Prabhdeep Singh on 7/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import Foundation

extension Date {
  var year: Int {
    return Calendar(identifier: .gregorian).component(.year, from: self)
  }
  
  var month: Int {
    return Calendar(identifier: .gregorian).component(.month, from: self)
  }
}
