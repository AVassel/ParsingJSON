//
//  Device.swift
//  ParsingJSON
//
//  Created by Anton Vassel on 08.06.2022.
//

struct Good: Decodable {
    let id:             Int?
    let color:          String?
    let department:     String?
    let material:       String?
    let product_name:   String?
    let price:          Double?
    let promo_code:     String?
    
    var goodInfo: String {
                            """
                            Артикул: \(id ?? 0)
                            Отдел: \(department ?? "")
                            Название: \(product_name ?? "")
                            Материал: \(material ?? "")
                            Цвет: \(color ?? "")
                            Стоимость: \(price ?? 0.0)
                           """
    }
}
