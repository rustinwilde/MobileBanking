//
//  CustomButton.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 12.05.24.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureButton()
        
    }
    
    private func configureButton() {
        backgroundColor = .blue
        setTitleColor(.white, for: .normal)
        titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        layer.cornerRadius = 20
        translatesAutoresizingMaskIntoConstraints = false
    }
}
