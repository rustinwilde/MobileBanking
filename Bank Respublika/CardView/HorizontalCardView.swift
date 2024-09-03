////
////  HorizontalCardView.swift
////  Bank Respublika
////
////  Created by Rustin Wilde on 28.06.24.
////
//
//import SwiftUI
//
//struct HorizontalCardView: View {
//    
//    let cardData = [
//        BankCard(id: "1", name: "John Doe", amount: "12,345.67", type: "Debit", currency: "USD", cardNumber: "1234 5678 9012 3456"),
//        BankCard(id: "2", name: "Jane Smith", amount: "8,765.43", type: "Credit", currency: "EUR", cardNumber: "6543 2109 8765 4321")
//    ]
//    
//    var body: some View {
//        ScrollView(.horizontal, showsIndicators: false) {
//            HStack(spacing: 20) {
//                ForEach(cardData) { card in
//                    CardView(card: card)
//                        .frame(width: 300, height: 200) // Adjust the size as needed
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct CardView: View {
//    let card: BankCard
//    
//    var body: some View {
//        ZStack {
//            RoundedRectangle(cornerRadius: 15)
//                .fill(Color.blue)
//                .frame(height: 200)
//                .shadow(color: Color.gray.opacity(0.2), radius: 5, x: 10, y: 15)
//            
//            VStack(alignment: .leading, spacing: 20) {
//                HStack {
//                    Text("Bank Respublika")
//                        .font(.subheadline)
//                        .foregroundStyle(Color.white)
//                        .fontWeight(.bold)
//                    Spacer()
//                    Image("mastercard")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: 65, height: 55)
//                }
//                
//                HStack {
//                    Text(card.name)
//                        .font(.system(size: 15, weight: .regular, design: .monospaced))
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.white)
//                    Spacer()
//                }
//                
//                Text(card.cardNumber)
//                    .font(.system(size: 25, weight: .regular, design: .monospaced))
//                    .foregroundColor(Color.white)
//                    .fontWidth(.expanded)
//                    .padding(.horizontal)
//
//                HStack {
//                    Text(card.type)
//                        .font(.subheadline)
//                        .foregroundColor(Color.white)
//                    Spacer()
//                    Text(card.amount)
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(Color.white)
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//
//
//struct HorizontalCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        HorizontalCardView()
//    }
//}
