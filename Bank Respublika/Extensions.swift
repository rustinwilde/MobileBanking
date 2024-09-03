//
//  Extensions.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 10.05.24.
//

import UIKit

public extension UIFont {
     enum SFPro: String {
        case bold = "SourceSansPro-Bold"
        case regular = "SourceSansPro-Regular"
        case light = "SourceSansPro-Light"
        case mediumM = "Montserrat-Medium"
    }
    enum Montserrat: String {
        case semiBold = "Montserrat-VariableFont_wght"
        case semibold = "Montserrat-SemiBold"
    }
}

enum TrailingContent {
    case readmore
    case readless
    var text: String {
        switch self {
        case .readmore: return "...Read More"
        case .readless: return " Read Less"
        }
    }
}
extension UILabel {
    private var minimumLines: Int { return 4 }
    private var highlightColor: UIColor { return .red }
    private var attributes: [NSAttributedString.Key: Any] {
        return [.font: self.font ?? .systemFont(ofSize: 18)]
    }
    public func requiredHeight(for text: String) -> CGFloat {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = minimumLines
        label.lineBreakMode = NSLineBreakMode.byTruncatingTail
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.height
    }
    func highlight(_ text: String, color: UIColor) {
        guard let labelText = self.text else { return }
        let range = (labelText as NSString).range(of: text)
        let mutableAttributedString = NSMutableAttributedString.init(string: labelText)
        mutableAttributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
        self.attributedText = mutableAttributedString
    }
    func appendReadmore(after text: String, trailingContent: TrailingContent) {
        self.numberOfLines = minimumLines
        let fourLineText = "\n\n\n"
        let fourlineHeight = requiredHeight(for: fourLineText)
        let sentenceText = NSString(string: text)
        let sentenceRange = NSRange(location: 0, length: sentenceText.length)
        var truncatedSentence: NSString = sentenceText
        var endIndex: Int = sentenceRange.upperBound
        let size: CGSize = CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude)
        while truncatedSentence.boundingRect(with: size, options: .usesLineFragmentOrigin, attributes: attributes, context: nil).size.height >= fourlineHeight {
            if endIndex == 0 {
                break
            }
            endIndex -= 1
            truncatedSentence = NSString(string: sentenceText.substring(with: NSRange(location: 0, length: endIndex)))
            truncatedSentence = (String(truncatedSentence) + trailingContent.text) as NSString
        }
        self.text = truncatedSentence as String
        self.highlight(trailingContent.text, color: highlightColor)
    }
    func appendReadLess(after text: String, trailingContent: TrailingContent) {
        self.numberOfLines = 0
        self.text = text + trailingContent.text
        self.highlight(trailingContent.text, color: highlightColor)
    }
}

enum TextConstants {
    static let descriptionLong = "You no longer need to purchase debit and installment cards separately. We have combined these functions in the Birbank Cashback card. \nWhen you order a card, we check your detalls, which usually takes a few seconds. \nIf you need an installment card, proceed with the order after the verification is completed. If you are entitled to a loan, a credit line will be activated on your card. \nIf you want to order a debit card, after verification, click the \n'I want a debit card' button. If the credit line will not be activated or you order a debit card, in any case you will have the opportunity to apply for credit line activation later through the Birbank app."
    static let descriptionShort = "You no longer need to purchase debit and installment cards separately. We have combined these functions in the Birbank Cashback..."
}
