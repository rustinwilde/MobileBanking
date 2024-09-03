//
//  CardDetailService.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 24.06.24.
//

import UIKit

class CardDetailService {
    func fetchCardDetails() -> [CardDetail] {
        return [
            CardDetail(title: "Card delivery", detail: "Free", detailColor: .red, infoAvailable: true),
            CardDetail(title: "Card price", detail: "Free", detailColor: .red, infoAvailable: true),
            CardDetail(title: "Transfer and withdrawal", detail: "Free", detailColor: .red, infoAvailable: true),
            CardDetail(title: "Grace period", detail: "Up to 63 days", detailColor: .black, infoAvailable: true),
            CardDetail(title: "Bonuses", detail: "2x VAT, up to 30% cashback", detailColor: .black, infoAvailable: true),
            CardDetail(title: "Installments", detail: "Up to 24 months", detailColor: .black, infoAvailable: true),
        ]
    }
}
