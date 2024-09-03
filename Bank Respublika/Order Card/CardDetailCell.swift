//
//  CardDetailCell.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 24.06.24.
//

import UIKit

class CardDetailCell: UITableViewCell {
    
    private let titleLabel = UILabel()
    private let detailLabel = UILabel()
    private let infoButton = UIButton(type: .infoLight)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(detailLabel)
        contentView.addSubview(infoButton)
        
        titleLabel.font = UIFont.systemFont(ofSize: 14)
        titleLabel.textColor = .lightGray
        detailLabel.font = UIFont.systemFont(ofSize: 14)
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.centerY.equalToSuperview()
        }
        
        detailLabel.snp.makeConstraints { make in
            make.trailing.equalTo(infoButton.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
        }
        
        infoButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    func configure(with detail: CardDetail) {
        titleLabel.text = detail.title
        detailLabel.text = detail.detail
        detailLabel.textColor = detail.detailColor
        infoButton.isHidden = !detail.infoAvailable
    }
}
