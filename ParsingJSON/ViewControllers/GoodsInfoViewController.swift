//
//  GoodsInfoViewController.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 09.06.2022.
//

import UIKit

class GoodsInfoViewController: UIViewController {
    
    var promo: String!

    @IBOutlet weak var promoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        promoLabel.text = promo
    }
}
