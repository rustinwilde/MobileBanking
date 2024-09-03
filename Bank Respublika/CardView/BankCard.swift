//
//  BankCard.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 10.05.24.
//

import SwiftUI

struct ContentView: View {
    let user: UserPersonalInformation
    let cardData: [BankCardInformation]
    
    init() {
        let user = UserPersonalInformation(name: "John Doe", phoneNumber: "1234567890", dateOfBirth: "01/01/1980")
        self.user = user
        self.cardData = [BankCardInformation(user: user)]
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                ForEach(cardData) { card in
                    CardView(card: card)
                }
            }
            .padding()
        }
    }
}

struct CardView: View {
  @ObservedObject var card: BankCardInformation
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 15)
                .fill(Color.blue)
                .frame(height: 200)
                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 10, y: 15)
            
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Bank Respublika")
                        .font(.subheadline)
                        .foregroundStyle(Color.white)
                        .fontWeight(.bold)
                    Spacer()
                    Image("mastercard")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 65, height: 55)
                }
                
                HStack {
                    Text(card.user.name)
                        .font(.system(size: 15, weight: .regular, design: .monospaced))
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                
                Text(card.formattedCardNumber)
                    .font(.system(size: 22, weight: .regular, design: .monospaced))
                    .foregroundColor(Color.white)
                    .fontWidth(.expanded)
                    .padding(.horizontal)

                HStack {
                    Text(card.type)
                        .font(.subheadline)
                        .foregroundColor(Color.white)
                    Spacer()
                    Text(card.formattedBalance)
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(Color.white)
                }
            }
            .padding()
        }
        .contextMenu {
                    Button(action: {
                        card.user.removeCard(card)
                    }) {
                        Label("Delete Card", systemImage: "trash")
                    }
                }
    }
}

struct CardVerticalView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .topLeading, endPoint: .bottomTrailing))
                .shadow(radius: 10)
            HStack {
                Text("Bank \nRespublika")
                    .foregroundColor(.white)
                    .font(.headline)
                    .fontWeight(.bold)
                    .padding(.leading, 10)
                
                Spacer()
                Text("Cashback")
                    .foregroundColor(.white)
                    .font(.system(size: 12))
                    .fontWeight(.bold)
                    .padding(.trailing, 5)
            }
            .padding(.top, -130)
            Spacer()
            
            HStack {
                Image("contactless")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 30)
                    .position(x: 30, y: 120)
                    .foregroundStyle(Color.white)
            }
            
            VStack {
                Image("mastercard")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 50)
                    .position(x: 200, y: 300)
            }
        }
    }
}


    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
            CardVerticalView()
                .frame(width: 230, height: 330)
        }
    }
