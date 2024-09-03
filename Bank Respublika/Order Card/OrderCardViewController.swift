//
//  OrderCardViewController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 12.05.24.
//

import UIKit
import SwiftUI
import SnapKit

protocol OrderCardViewControllerDelegate: AnyObject {
    func didCreateNewCard(_ card: BankCardInformation)
}

class OrderCardViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableLabelViewControllerDelegate {
    
    // MARK: Propertiesr
    private let cardVerticalView = CardVerticalView()
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private var data: [CardDetail] = []
    private let cardDetailService = CardDetailService()
    private var expandableLabelHeightConstraint: Constraint?
    private var isExtended: Bool = false
    weak var delegate: OrderCardViewControllerDelegate?
    var userPersonalInformation: UserPersonalInformation
    
    init(userPersonalInformation: UserPersonalInformation) {
        self.userPersonalInformation = userPersonalInformation
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let cardName: UILabel = {
        let label = UILabel()
        label.text = Consts.Texts.cardName
        label.font = UIFont(name: UIFont.SFPro.bold.rawValue, size: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionHeadline: UILabel = {
        let label = UILabel()
        label.text = Consts.Texts.headlineTitle
        label.font = UIFont(name: UIFont.SFPro.bold.rawValue, size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var expandableLabelViewController: ExpandableLabelViewController?
    
    private let cardTarrifsHeadline: UILabel = {
        let label = UILabel()
        label.text = Consts.Texts.headlineTariffsTitle
        label.font = UIFont(name: UIFont.SFPro.bold.rawValue, size: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tableView = UITableView()
    
    private let orderCardButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Order", for: .normal)
        button.addTarget(self, action: #selector(createCardButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupCardName()
        setupScrollContentView()
        setupDescriptionHeadline()
        setupSwiftUIView()
        setupExpandableLabelViewController()
        setupCardTarrifsHeadline()
        setupTableView()
        setupOrderCardButton()
        loadData()
    }
    
    private func setupSubviews() {
        view.addSubview(cardName)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(descriptionHeadline)
        contentView.addSubview(cardTarrifsHeadline)
        contentView.addSubview(tableView)
        contentView.addSubview(orderCardButton)
    }
    
    private func loadData() {
        data = cardDetailService.fetchCardDetails()
        tableView.reloadData()
    }
    
    // MARK: UITableViewDataSource Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CardDetailCell", for: indexPath) as! CardDetailCell
        cell.configure(with: data[indexPath.row])
        return cell
    }
    
    // MARK: Setup methods
    private func setupCardName() {
        cardName.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(15)
            make.width.equalTo(200)
            make.height.equalTo(25)
        }
    }
    
    private func setupScrollContentView() {
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(cardName.snp.bottom).offset(20)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height)
        }
    }
    
    private func setupDescriptionHeadline() {
        descriptionHeadline.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(360)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
    }
    
    private func setupSwiftUIView() {
        let cardVerticalViewKit = UIHostingController(rootView: cardVerticalView)
        addChild(cardVerticalViewKit)
        contentView.addSubview(cardVerticalViewKit.view)
        cardVerticalViewKit.didMove(toParent: self)
        cardVerticalViewKit.view.translatesAutoresizingMaskIntoConstraints = false
        cardVerticalViewKit.view.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(15)
            make.centerX.equalTo(contentView.snp.centerX)
            make.width.equalTo(230)
            make.height.equalTo(330)
        }
    }
    
    private func setupExpandableLabelViewController() {
        let shortText = Consts.Texts.subheadlineShortDescription
        let fullText = Consts.Texts.subheadlineLongDescription
        
        expandableLabelViewController = ExpandableLabelViewController(shortText: shortText, fullText: fullText)
        
        guard let expandableLabelViewController = expandableLabelViewController else {
            return
        }
        
        addChild(expandableLabelViewController)
        contentView.addSubview(expandableLabelViewController.view)
        expandableLabelViewController.didMove(toParent: self)
        expandableLabelViewController.delegate = self
        
        expandableLabelViewController.view.snp.makeConstraints { make in
            make.top.equalTo(descriptionHeadline.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.trailing.equalTo(contentView.snp.trailing).offset(-15)
            let initialHeight = expandableLabelViewController.requiredHeight()
            expandableLabelHeightConstraint = make.height.equalTo(initialHeight).constraint
        }
    }
    
    private func setupCardTarrifsHeadline() {
        guard let expandableLabelViewController = expandableLabelViewController else { return }
        
        cardTarrifsHeadline.snp.makeConstraints { make in
            make.top.equalTo(expandableLabelViewController.view.snp.bottom).offset(10)
            make.leading.equalTo(contentView.snp.leading).offset(15)
            make.width.equalTo(150)
            make.height.equalTo(25)
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isScrollEnabled = false
        tableView.isEditing = false
        tableView.register(CardDetailCell.self, forCellReuseIdentifier: "CardDetailCell")
        
        if !isExtended{
            tableView.snp.makeConstraints { make in
                make.top.equalTo(cardTarrifsHeadline.snp.bottom).offset(10)
                make.leading.trailing.equalTo(contentView).inset(15)
                make.bottom.equalTo(orderCardButton.snp.top).offset(20)
                make.height.equalTo(250)
                isExtended.toggle()
            }
        } else {
            tableView.snp.makeConstraints { make in
                make.top.equalTo(cardTarrifsHeadline.snp.bottom).offset(10)
                make.leading.trailing.equalTo(contentView).inset(15)
                make.bottom.equalTo(orderCardButton.snp.top).offset(180)
                make.height.equalTo(250)
                isExtended.toggle()
                
            }
        }
    }
    

    
    func didUpdateHeight() {
        guard let expandableLabelViewController = expandableLabelViewController else { return }
        
        let requiredHeight = expandableLabelViewController.requiredHeight()
        expandableLabelHeightConstraint?.update(offset: requiredHeight)
        
        UIView.animate(withDuration: 0.3) {
            self.contentView.layoutIfNeeded()
            self.scrollView.layoutIfNeeded()
        }
    }
    
    private func setupOrderCardButton() {
        if isExtended {
            orderCardButton.snp.makeConstraints { make in
                make.bottom.equalTo(contentView.snp.bottom).offset(-30)
                make.leading.equalTo(contentView.snp.leading).inset(30)
                make.trailing.equalTo(contentView.snp.trailing).inset(30)
                make.height.equalTo(53)
                isExtended.toggle()
            }
        } else {
            orderCardButton.snp.makeConstraints { make in
                make.bottom.equalTo(contentView.snp.bottom).inset(10)
                make.leading.equalTo(contentView.snp.leading).inset(30)
                make.trailing.equalTo(contentView.snp.trailing).inset(30)
                make.height.equalTo(53)
                isExtended.toggle()
            }
        }
    }
    
    @objc func createCardButtonTapped() {
        
        userPersonalInformation = UserPersonalInformation(name: userPersonalInformation.name, phoneNumber: userPersonalInformation.phoneNumber, dateOfBirth: userPersonalInformation.dateOfBirth)
        let newCard = BankCardInformation(user: userPersonalInformation)
        
        userPersonalInformation.addCard(newCard)
        delegate?.didCreateNewCard(newCard)
        
        navigationController?.popViewController(animated: true)
    }
}

extension OrderCardViewController {
    private enum Consts {
        enum Texts {
            static var cardName: String { NSLocalizedString("order_card_name_screen_headline_title", comment: "") }
            static var headlineTitle: String { NSLocalizedString("order_card_headline_title", comment: "") }
            static var subheadlineShortDescription: String { NSLocalizedString("order_card_subheadline_description_short_title", comment: "") }
            static var subheadlineLongDescription: String { NSLocalizedString("order_card_subheadline_description_long_title", comment: "") }
            static var headlineTariffsTitle: String { NSLocalizedString("order_card_headline_tariffs_title", comment: "") }
            static var cardDelieveryTitle: String { NSLocalizedString("order_card_card_delivery_title", comment: "") }
            static var cardPriceTitle: String { NSLocalizedString("order_card_card_price_title", comment: "") }
            static var transferAndWithdrawalTitle: String { NSLocalizedString("order_card_transfer_and_withdrawal_title", comment: "") }
            static var freeDescription: String { NSLocalizedString("order_card_free_description", comment: "") }
            static var gracePeriodTitle: String { NSLocalizedString("order_card_grace_period_title", comment: "") }
            static var gracePeriodDescription: String { NSLocalizedString("order_card_grace_period_description", comment: "") }
            static var bonusesTitle: String { NSLocalizedString("order_card_bonuses_title", comment: "") }
            static var bonusesDescription: String { NSLocalizedString("order_card_bonuses_description", comment: "") }
            static var installmentsTitle: String { NSLocalizedString("order_card_installments_title", comment: "") }
            static var installmentsDescription: String { NSLocalizedString("order_card_installments_description", comment: "") }
            static var buttonTitle: String { NSLocalizedString("order_card_button_title", comment: "") }
        }
    }
}
