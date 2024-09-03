//
//  UserPersonalInformation.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 10.05.24.
//

import Foundation
import Combine

class UserPersonalInformation: ObservableObject {
    
    let id: UUID
    let name: String
    let phoneNumber: String
    let dateOfBirth: String
    @Published private(set) var cards: [BankCardInformation] = []
    private var cancellables = Set<AnyCancellable>()
    
    private let cardManager: CardManager
    
    init(name: String, phoneNumber: String, dateOfBirth: String, cardManager: CardManager = CardManager.shared) {
        self.id = UUID()
        self.name = name
        self.phoneNumber = phoneNumber
        self.dateOfBirth = dateOfBirth
        self.cardManager = cardManager
        
        bindCardsToCardManager()
    }
    
    private func bindCardsToCardManager() {
        $cards
            .sink { updatedCards in
                CardManager.shared.syncCards(with: updatedCards)
            }
            .store(in: &cancellables)
    }
    
    func addCard(_ card: BankCardInformation) {
        cards.append(card)
        cardManager.addCard(card)
    }
    
    func removeCard(_ card: BankCardInformation) {
        if let index = cards.firstIndex(where: { $0.id == card.id }) {
            cards.remove(at: index)
            cardManager.deleteCard(card.id)
        }
    }
    
    func getID(card: BankCardInformation) -> UUID {
        return card.id
    }
}
