//
//  GoodInfoTableViewController.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 10.06.2022.
//

import UIKit
import Alamofire

class GoodInfoTableViewController: UITableViewController {
    var goodsPromoCount: Int!
    private var promo: String?
    private var goodsInfo: [Good] = []
    private var link: String {
        "https://random-data-api.com/api/commerce/random_commerce?size=\(goodsPromoCount ?? 1)"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func fetchData() {
        AF.request(link)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    self.goodsInfo = Good.getGoodsInfo(from: value)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        goodsInfo.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Good", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = goodsInfo[indexPath.row].goodInfo
        cell.contentConfiguration = content
        
        return cell
    }
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let good = goodsInfo[indexPath.row]
        promo = good.promoCode
        navigationItem.backButtonTitle = good.productName

        performSegue(withIdentifier: "moreInfo", sender: self)
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "moreInfo" {
            guard let goodsInfoVC = segue.destination as? GoodsInfoViewController else { return }
            goodsInfoVC.promo = promo ?? ""
        }
    }
}
