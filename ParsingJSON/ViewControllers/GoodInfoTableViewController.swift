//
//  GoodInfoTableViewController.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 10.06.2022.
//

import UIKit

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
        NetworkManager.fetchGoodInfo(from: link) { good in
            self.goodsInfo = good
            DispatchQueue.main.async {
                self.tableView.reloadData()
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
        promo = good.promo_code
        navigationItem.backButtonTitle = good.product_name

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
