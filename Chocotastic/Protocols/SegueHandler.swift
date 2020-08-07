//  Created by Prabhdeep Singh on 7/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import UIKit

/*
 Protocol to make sure all segues are handled safely. More on this techinque:
 https://www.natashatherobot.com/protocol-oriented-segue-identifiers-swift/
 */
protocol SegueHandler {
  associatedtype SegueIdentifier: RawRepresentable
}

extension SegueHandler //Default implementation...
    where Self: UIViewController, //for view controllers...
    SegueIdentifier.RawValue == String { //who have String segue identifiers.
  func performSegue(withIdentifier identifier: SegueIdentifier, sender: AnyObject? = nil) {
    performSegue(withIdentifier: identifier.rawValue, sender: sender)
  }
  
  func identifier(forSegue segue: UIStoryboardSegue) -> SegueIdentifier {
    guard
      let stringIdentifier = segue.identifier,
      let identifier = SegueIdentifier(rawValue: stringIdentifier)
      else {
        fatalError("Couldn't find identifier for segue!")
    }
    
    return identifier
  }
}
