//
//  CustomTextField.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 09.05.24.
//

import UIKit

class CustomTextField: UITextField {
    
    private let bottomLine = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        lineInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        lineInit()
    }
    
    private func lineInit() {
        bottomLine.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateBottomLineFrame()
    }
    
    private func updateBottomLineFrame() {
        bottomLine.frame = CGRect(x: 0, y: self.bounds.height - 2, width: self.bounds.width + 30, height: 2)
    }
    
    override func becomeFirstResponder() -> Bool {
        let result = super.becomeFirstResponder()
        if result {
            bottomLine.backgroundColor = UIColor.blue.cgColor
        }
        return result
    }
    
    override func resignFirstResponder() -> Bool {
        let result = super.resignFirstResponder()
        if result {
            bottomLine.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 1).cgColor
        }
        return result
    }
}


