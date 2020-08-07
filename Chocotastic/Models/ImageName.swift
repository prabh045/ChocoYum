//  Created by Prabhdeep Singh on 06/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import UIKit

enum ImageName: String {
  case
  amex,
  discover,
  mastercard,
  visa,
  unknownCard
  
  var image: UIImage? {
    guard let image = UIImage(named: rawValue) else {
      return nil
    }
    
    return image
  }
}
