//
//  SelectDestinationCardViewController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 04.08.24.
//

import SwiftUI
import UIKit
import SnapKit

struct SelectedDestinationCardView: View {
    @State private var activeID: UUID?
    @State private var showSuccessView = false
    @State private var navigationPath = [UUID?]()
    
    var cardManager: CardManager?
    let availableCards: [BankCardInformation]
    let transferedAmount: Double?
    var selectedCardID: UUID
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            VStack {
                HStack(spacing: 0) {
                    Text("Select destination card ")
                        .font(.custom("Montserrat-Semibold", size: 22))
                    
                    Text("💳")
                        .font(.system(size: 27))
                }
                .padding(.top, 250)
                
                CustomCarousel(
                    config: .init(hasOpacity: false, hasScale: true, cardWidth: 335, minimumCardWidth: 20),
                    selection: $activeID,
                    data: availableCards
                ) { card in
                    CardView(card: card)
                        .frame(height: 210)
                        .onTapGesture {
                            withAnimation(.easeInOut) {
                                activeID = card.id
                                cardManager?.transfer(from: selectedCardID, to: card.id, amount: transferedAmount ?? 0.0)
                                navigationPath.append(card.id)
                            }
                        }
                }
                .padding(.bottom, 250)
            }
            .background(Color.gray.opacity(0.19))
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(.easeInOut) {
                    print("Available cards: \(availableCards)")
                }
            }
            .navigationDestination(for: UUID?.self) { _ in
                           SuccessAnimationView(onHomeButtonTapped: {
                               if let navController = UIApplication.shared.windows.first?.rootViewController as? UINavigationController {
                                   if let mainMenuVC = navController.viewControllers.first(where: { $0 is MainMenuViewController }) {
                                       navController.popToViewController(mainMenuVC, animated: true)
                                   }
                               }
                           })
                           .navigationBarBackButtonHidden()
                       }
                   }
        .navigationBarBackButtonHidden()
        }
    }




class SelectedDestinationCardHostingController: UIHostingController<SelectedDestinationCardView> {
    var selectedCardID: UUID
    var transferedAmount: Double?
    var availableCards: [BankCardInformation]
    
    init(selectedCardID: UUID, transferedAmount: Double?, availableCards: [BankCardInformation], cardManager: CardManager?) {
        self.selectedCardID = selectedCardID
        self.transferedAmount = transferedAmount
        self.availableCards = availableCards
        
        let rootView = SelectedDestinationCardView(
            cardManager: cardManager,
            availableCards: availableCards,
            transferedAmount: transferedAmount,
            selectedCardID: selectedCardID
        )
        
        super.init(rootView: rootView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let count = navigationController?.viewControllers.count ?? 0
        print("Number of view controllers in the navigation stack: \(count)")
        print("Available cards from hosting controller: \(availableCards)")
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//#Preview {
//    SelectedDestinationCardHostingController()
//}

