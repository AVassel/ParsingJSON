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
        NetworkManager.fetch(dataType: [Good].self, from: link, with: { result in
            switch result {
            case .success(let good):
                self.goodsInfo = good
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        })
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
