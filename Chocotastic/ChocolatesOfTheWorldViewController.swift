
//  Created by Prabhdeep Singh on 05/08/20.
//  Copyright © 2020 Prabh. All rights reserved.

import UIKit
import RxSwift
import RxCocoa

class ChocolatesOfTheWorldViewController: UIViewController {
  @IBOutlet private var cartButton: UIBarButtonItem!
  @IBOutlet private var tableView: UITableView!
  let europeanChocolates = Observable.just(Chocolate.ofEurope)
  private let disposeBag = DisposeBag()
  
}

//MARK: View Lifecycle
extension ChocolatesOfTheWorldViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Chocolate!!!"
    setupCartObserver()
    setupCellConfiguration()
    setupCellTapHandling()
  }
  
}

//MARK: - Rx Setup
private extension ChocolatesOfTheWorldViewController {
  //Remeber to dispose observers so that arc can work properly
  func setupCartObserver() {
    ShoppingCart.sharedCart.chocolates.asObservable().subscribe(onNext: {  [weak self] (chocolates) in
      self?.cartButton.title = "\(chocolates.count) \u{1f36b}"
      }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
  }
  
  //equivalent to cell for row at indexpath
  // number of rows are calculated automatiocally
  func setupCellConfiguration() {
    europeanChocolates.bind(to: tableView.rx.items(cellIdentifier: ChocolateCell.Identifier, cellType: ChocolateCell.self)) {
      row, chocolate, cell in
      cell.configureWithChocolate(chocolate: chocolate)
    }.disposed(by: disposeBag)
  }
  
  //for handling selection of rows
  func setupCellTapHandling(){
    tableView.rx.modelSelected(Chocolate.self).subscribe(onNext: { [unowned self] (chocolate) in
      let newValue =  ShoppingCart.sharedCart.chocolates.value + [chocolate]
      //value of observale changes through accept
         ShoppingCart.sharedCart.chocolates.accept(newValue)
      
      if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
        self.tableView.deselectRow(at: selectedIndexPath, animated: true)
      }
      
      }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: disposeBag)
  }
}

//MARK: - Imperative methods
private extension ChocolatesOfTheWorldViewController {
//  func updateCartButton() {
//    cartButton.title = "\(ShoppingCart.sharedCart.chocolates.value.count) 🍫"
//  }
}



// MARK: - SegueHandler
extension ChocolatesOfTheWorldViewController: SegueHandler {
  enum SegueIdentifier: String {
    case goToCart
  }
}
