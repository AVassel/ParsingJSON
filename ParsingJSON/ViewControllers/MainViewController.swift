//
//  ViewController.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 08.06.2022.
//

import UIKit



class MainViewController: UIViewController {

    @IBOutlet weak var numberOfGoodsLabel: UILabel!
    @IBOutlet weak var goodStepper: UIStepper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goodInfo" {
            guard let goodInfoVC = segue.destination as? GoodInfoTableViewController else { return }
            goodInfoVC.goodsPromoCount = Int(goodStepper.value)
        }
    }
    
    @IBAction func goodStepperChange(_ sender: UIStepper) {
        numberOfGoodsLabel.text = Int(sender.value).description
    }
    
    @IBAction func goodInfoButtonPressed(_ sender: UIButton) {
    }
    
}

