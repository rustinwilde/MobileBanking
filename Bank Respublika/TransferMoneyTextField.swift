//
//  TransferMoneyTextField.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 18.07.24.
//

import UIKit
import Combine

class TransferMoneyTextField: UITextField, UITextFieldDelegate {
    @Published private(set) var amountText: String = ""
    private var cancellables = Set<AnyCancellable>()
    private let currencySymbol = "₼"
    private let maximumValue = 1000000.0
    var cleanText: String = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        self.borderStyle = .none
        self.backgroundColor = UIColor.clear
        
        self.font = UIFont(name: "Montserrat-SemiBold", size: 45)
        self.textColor = UIColor.black
        
        self.attributedPlaceholder = NSAttributedString(
            string: "0₼",
            attributes: [.foregroundColor: UIColor.lightGray]
        )
        
        self.keyboardType = .decimalPad
        self.delegate = self
        self.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
    }
    
    @objc private func textDidChange() {
        guard let text = self.text else { return }
        let textWithoutCurrency = text.replacingOccurrences(of: currencySymbol, with: "")
        let cleanedText = textWithoutCurrency.trimmingCharacters(in: .whitespacesAndNewlines)
        self.cleanText = cleanedText
        
        if let value = Double(cleanedText), value > maximumValue {
            amountText = String(format: "%.0f", maximumValue)
            self.text = "\(amountText)\(currencySymbol)"
        } else {
            amountText = cleanedText
            updateTextField(amountText)
        }
        
        if let textPosition = self.position(from: self.endOfDocument, offset: -1) {
            self.selectedTextRange = self.textRange(from: textPosition, to: textPosition)
        }
    }
    
    private func updateTextField(_ newText: String) {
        if newText.isEmpty {
            self.text = ""
        } else {
            var formattedText = newText.trimmingCharacters(in: CharacterSet(charactersIn: "0"))
            formattedText = "\(formattedText)\(currencySymbol)"
            self.text = formattedText
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currentText = textField.text else { return true }
        
        var updatedText = (currentText as NSString).replacingCharacters(in: range, with: string)
        
        if updatedText.first == "," {
            updatedText = "0." + updatedText.dropFirst()
        } else if updatedText.hasPrefix(",") {
            updatedText = "0" + updatedText
        }
        
        let textWithoutCurrency = updatedText.replacingOccurrences(of: currencySymbol, with: "")
        
        if let value = Double(textWithoutCurrency), value > maximumValue {
            return false
        }

        textField.text = updatedText
        
        if let textPosition = textField.position(from: textField.endOfDocument, offset: -currencySymbol.count) {
            textField.selectedTextRange = textField.textRange(from: textPosition, to: textPosition)
        }
        
        return false
    }
}
