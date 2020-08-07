//  Created by Prabhdeep Singh on 07/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import UIKit
import RxSwift
import RxCocoa

class CartViewController: UIViewController {
  @IBOutlet private var checkoutButton: UIButton!
  @IBOutlet private var totalItemsLabel: UILabel!
  @IBOutlet private var totalCostLabel: UILabel!
  @IBOutlet weak var cartTableView: UITableView!
  let disposeBag = DisposeBag()
}

//MARK: - View lifecycle
extension CartViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Cart"
    //configureFromCart()
  
  }
  override func viewDidAppear(_ animated: Bool) {
    setupCell()
    setupCartCost()
  }
}

//MARK: - IBActions
extension CartViewController {
  @IBAction func reset() {
    ShoppingCart.sharedCart.chocolates.accept([])
    let _ = navigationController?.popViewController(animated: true)
  }
}

//MARK: - Configuration methods
private extension CartViewController {
  func configureFromCart() {
    guard checkoutButton != nil else {
      //UI has not been instantiated yet. Bail!
      return
    }
    
    let cart = ShoppingCart.sharedCart
   // totalItemsLabel.text = cart.itemCountString
    
    let cost = cart.totalCost.value
    totalCostLabel.text = CurrencyFormatter.dollarsFormatter.string(from: cost)
    
    //Disable checkout if there's nothing to check out with
    checkoutButton.isEnabled = (cost > 0)
  }
}

private extension CartViewController {
  
  func setupCartCost() {
    ShoppingCart.sharedCart.totalCost.asObservable().subscribe(onNext: { (cost) in
      self.totalCostLabel.text = CurrencyFormatter.dollarsFormatter.string(from: cost)
      self.checkoutButton.isEnabled = (cost > 0)
      }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
    
    
  }
  
  func setupCell() {
    ShoppingCart.sharedCart.itemCountString.asObservable().bind(to: self.cartTableView.rx.items(cellIdentifier: "cartCell", cellType: UITableViewCell.self)) {
      row, item, cell in
      cell.textLabel?.text = item
    }.disposed(by: disposeBag)
  }
  
}
