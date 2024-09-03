//
//  BankCardInformation.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 28.06.24.
//

import UIKit


class BankCardInformation: Identifiable, ObservableObject {
    let id: UUID = .init()
    let user: UserPersonalInformation
    @Published var balance: Double
    let cardNumber: String
    let type: String
    let currency: String
    
    init(user: UserPersonalInformation) {
        self.user = user
        self.balance = 10.00
        self.type = "Debit"
        self.currency = "AZN"
        self.cardNumber = BankCardInformation.generateCardNumber()
    }
    
    private static func generateCardNumber() -> String {
        return (0..<16).map { _ in String(Int.random(in: 0...9)) }.joined()
    }
    
    var formattedCardNumber: String {
            return cardNumber.enumerated().map { index, character in
                return (index % 4 == 0 && index > 0) ? " \(character)" : "\(character)"
            }.joined()
        }
    
    var formattedBalance: String {
        return "\(balance) ₼"
    }
}

extension BankCardInformation {
    static func makeSampleCards() -> [BankCardInformation] {
        let testUser1 = UserPersonalInformation(name: "Rustin Wilde", phoneNumber: "+994 50 123 45 67", dateOfBirth: "01-01-1980")
        let testUser2 = UserPersonalInformation(name: "Lara Smith", phoneNumber: "+994 50 987 65 43", dateOfBirth: "02-02-1985")
        
        let card1 = BankCardInformation(user: testUser1)
        let card2 = BankCardInformation(user: testUser2)
        let card3 = BankCardInformation(user: testUser1)
        
        return [card1, card2, card3]
    }

    
}
