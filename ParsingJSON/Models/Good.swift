//
//  Device.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 08.06.2022.
//

import Foundation

struct Good: Decodable {
    let id: Int?
    let color: String?
    let department: String?
    let material: String?
    let productName: String?
    let price: Double?
    let promoCode: String?
    
    var goodInfo: String {
                            """
                            Артикул: \(id ?? 0)
                            Отдел: \(department ?? "")
                            Название: \(productName ?? "")
                            Материал: \(material ?? "")
                            Цвет: \(color ?? "")
                            Стоимость: \(price ?? 0.0)
                           """
    }
    
    init(goodInfo: [String : Any]) {
        id = goodInfo["id"] as? Int
        color = goodInfo["color"] as? String
        department = goodInfo["department"] as? String
        material = goodInfo["material"] as? String
        productName = goodInfo["product_name"] as? String
        price = goodInfo["price"] as? Double
        promoCode = goodInfo["promo_code"] as? String
    }
    
    static func getGoodsInfo(from value: Any) -> [Good] {
        guard let goodsInfoData = value as? [[String : Any]] else { return [] }
        return goodsInfoData.compactMap {Good(goodInfo: $0)}
    }
}
