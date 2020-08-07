//  Created by Prabhdeep Singh on 06/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import Foundation
import RxSwift
import RxCocoa

class ShoppingCart {
  static let sharedCart = ShoppingCart()
  let chocolates: BehaviorRelay<[Chocolate]> = BehaviorRelay(value: [])
}

//MARK: Non-Mutating Functions
extension ShoppingCart {
  var totalCost: BehaviorRelay<Float> {
    return BehaviorRelay(value: chocolates.value.reduce(0) {
      runningTotal, chocolate in
      return runningTotal + chocolate.priceInDollars
    })
  }
  
  var itemCountString: BehaviorRelay<[String]> {
    guard chocolates.value.count > 0 else {
      return BehaviorRelay(value: ["🚫🍫"])
    }
    
    //Unique the chocolates
    let setOfChocolates = Set<Chocolate>(chocolates.value)
    
    //Check how many of each exists
    let itemStrings: [String] = setOfChocolates.map {
      chocolate in
      let count: Int = chocolates.value.reduce(0) {
        runningTotal, reduceChocolate in
        if chocolate == reduceChocolate {
          return runningTotal + 1
        }
        
        return runningTotal
      }
      
      return "\(chocolate.countryFlagEmoji)🍫: \(count)"
    }
    
    return BehaviorRelay(value: itemStrings)
  }
}
