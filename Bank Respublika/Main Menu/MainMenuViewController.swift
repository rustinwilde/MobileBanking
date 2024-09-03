//
//  UserAccountViewController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 10.05.24.
//

import UIKit
import SnapKit

import SwiftUI

struct MainMenuView: View {
    @ObservedObject var userInfo: UserPersonalInformation
    @State private var selectedCardID: UUID? = nil
    
    var onOrderCardTapped: () -> Void
    var onCardTapped: (BankCardInformation) -> Void
    var cardManager = CardManager()
    
    var body: some View {
        VStack {
            Text("Welcome, \(userInfo.name.components(separatedBy: " ").first ?? "")")
                .font(.custom(UIFont.SFPro.bold.rawValue, size: 28))
                .foregroundColor(Color(red: 3/255, green: 52/255, blue: 110/255))
                .padding(.top, 15)
                .padding(.leading, 20)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
                .padding(.horizontal, 25)
                .background(Color(red: 238/255, green: 238/255, blue: 238/255))
            
            CustomCarousel(config: .init(hasOpacity: false, hasScale: true, cardWidth: 335, minimumCardWidth: 20), selection: $selectedCardID, data: userInfo.cards) { card in
                CardView(card: card)
                    .frame(height: 210)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            selectedCardID = card.id
                            onCardTapped(card)
                        }
                    }
                    .background(
                        ForceTouchWrapper {
                            // Handle delete action
                            userInfo.removeCard(card)
                        }
                    )
            }
            .frame(height: 200)
            .padding(.vertical, 20)
            
            Spacer()
            
            Button(action: {
                onOrderCardTapped()
            }) {
                Text("Order Card")
                    .frame(height: 53)
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
            .padding(.bottom, 30)
        }
        .background(Color.white)
    }
}

class MainMenuViewController: UIViewController, OrderCardViewControllerDelegate {
    
    private var userInfo: UserPersonalInformation
    private var hostingController: UIHostingController<MainMenuView>?
    
    init(userInfo: UserPersonalInformation) {
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHostingController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func configureHostingController() {
        let mainMenuView = MainMenuView(
            userInfo: userInfo,
            onOrderCardTapped: { [weak self] in
                self?.navigateToOrderCardView()
            },
            onCardTapped: { [weak self] card in
                self?.navigateToTransferMoneyView(with: card)
            }
        )
        
        let newHostingController = UIHostingController(rootView: mainMenuView)
        
        if let oldHostingController = hostingController {
            oldHostingController.willMove(toParent: nil)
            oldHostingController.view.removeFromSuperview()
            oldHostingController.removeFromParent()
        }
        
        addChild(newHostingController)
        view.addSubview(newHostingController.view)
        newHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newHostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            newHostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            newHostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newHostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        newHostingController.didMove(toParent: self)
        
        hostingController = newHostingController
    }
    
    func didCreateNewCard(_ card: BankCardInformation) {
        userInfo.addCard(card)
        configureHostingController()
    }
    
    private func navigateToOrderCardView() {
        let orderCardVC = OrderCardViewController(userPersonalInformation: userInfo)
        orderCardVC.delegate = self
        navigationController?.pushViewController(orderCardVC, animated: true)
    }
    
    private func navigateToTransferMoneyView(with card: BankCardInformation) {
        let transferMoneyViewController = TransferMoneyViewViewController(selectedCard: card.id, userInfo: userInfo)
        navigationController?.pushViewController(transferMoneyViewController, animated: true)
    }
}

