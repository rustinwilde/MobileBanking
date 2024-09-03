//
//  CardManager.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 28.06.24.
//

import Foundation
import SwiftUI

class CardManager {
    static let shared = CardManager()
    
    @Published private(set) var cards: [UUID: BankCardInformation] = [:]
    
    func syncCards(with cards: [BankCardInformation]) {
        self.cards = Dictionary(uniqueKeysWithValues: cards.map { ($0.id, $0) })
    }
    
    func getAllCards() -> [BankCardInformation] {
        return Array(cards.values)
    }
    
    func addCard(_ card: BankCardInformation) {
        cards[card.id] = card
    }
    
    func deleteCard(_ cardID: UUID) {
        cards.removeValue(forKey: cardID)
    }
    
    func transfer(from sourceCardID: UUID, to destinationCardID: UUID, amount: Double) {
        if let sourceCard = findCard(by: sourceCardID), let destinationCard = findCard(by: destinationCardID) {
            sourceCard.balance -= amount
            destinationCard.balance += amount
        } else {
            return
        }
    }
    
    private func findCard(by id: UUID) -> BankCardInformation? {
        return cards[id]
    }
}
