//
//  BankCardCollectionViewCell.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 28.06.24.
//

import UIKit
import SwiftUI
import SnapKit

class BankCardCollectionViewCell: UICollectionViewCell {
    private var hostingController: UIHostingController<CardView>?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func configure(with card: BankCardInformation, isHorizontal: Bool, onDelete: @escaping () -> Void) {
        hostingController?.view.removeFromSuperview()
        hostingController?.removeFromParent()
        hostingController = nil
        
        let cardView = CardView(card: card)
        
        let newHostingController = UIHostingController(rootView: cardView)
        hostingController = newHostingController

        guard let hostingController = hostingController else { return }

        contentView.addSubview(hostingController.view)

        hostingController.view.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.leading.equalTo(contentView.snp.leading)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
        }

        hostingController.view.backgroundColor = .clear
    }
}
