//
//  TransferMoneyViewViewController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 17.07.24.
//

import UIKit
import SnapKit
import SwiftUI

class TransferMoneyViewViewController: UIViewController, UITextFieldDelegate {
    
    var selectedCard: UUID
    var userInfo: UserPersonalInformation
    
    init(selectedCard: UUID, userInfo: UserPersonalInformation) {
        self.selectedCard = selectedCard
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil) 
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let transferView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        return view
    }()
    
    private let transferAmount: TransferMoneyTextField = {
        let textfield = TransferMoneyTextField()
        textfield.textAlignment = .center
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private let sendButton: UIButton = {
        let button = UIButton()
        button.setTitle(Consts.Texts.nextButtonLabel, for: .normal)
        button.titleLabel?.font = UIFont(name: UIFont.Montserrat.semibold.rawValue, size: 16)
        button.backgroundColor = UIColor(red: 63/255, green: 162/255, blue: 246/255, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let balance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIFont.SFPro.regular.rawValue, size: 12)
        label.textColor = .lightGray
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferAmount.delegate = self
        setupSwiftUIView()
        setupSubviews()
        setupConstraints()
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupSwiftUIView() {
        let backgroundGradientViewKit = UIHostingController(rootView: GradientView())
        addChild(backgroundGradientViewKit)
        view.addSubview(backgroundGradientViewKit.view)
        backgroundGradientViewKit.didMove(toParent: self)
        backgroundGradientViewKit.view.translatesAutoresizingMaskIntoConstraints = false
        backgroundGradientViewKit.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupBalance() {
        
    }
    
    private func setupSubviews() {
        view.addSubview(transferView)
        view.addSubview(transferAmount)
        view.addSubview(sendButton)
    }
    
    private func setupConstraints() {
        transferView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).offset(80)
        }
        transferAmount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(280)
            make.height.equalTo(60)
        }
        sendButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
            make.leading.equalToSuperview().offset(15)
            make.trailing.equalToSuperview().offset(-15)
            make.height.equalTo(60)
        }
        
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func nextButtonTapped() {
        guard let doubleAmount = Double(transferAmount.cleanText) else { return }
        
        let availableCards = fetchOtherCards(excluding: selectedCard)
        
        let destinationVC = SelectedDestinationCardHostingController(
            selectedCardID: selectedCard,
            transferedAmount: doubleAmount,
            availableCards: availableCards,
            cardManager: CardManager.shared
        )
        
        self.navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    private func fetchOtherCards(excluding card: UUID?) -> [BankCardInformation] {
        guard let card = card else {
            return userInfo.cards
        }
        return userInfo.cards.filter { $0.id != card }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension TransferMoneyViewViewController {
    private enum Consts {
        enum Texts {
            static var sendButtonLabel: String { NSLocalizedString("send_amount_button_title", comment: "") }
            static var nextButtonLabel: String { NSLocalizedString("next_screen_button_title", comment: "")}
        }
    }
}
