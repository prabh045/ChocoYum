
//  Created by Prabhdeep Singh on 05/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import UIKit

/// Subclass to make status bar style work for views embedded in this navigation controller.
class ChocolateNavigationController: UINavigationController {
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .lightContent
  }
}
