//
//  OrderCardViewController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 12.05.24.
//


import UIKit
import SnapKit

protocol ExpandableLabelViewControllerDelegate: AnyObject {
    func didUpdateHeight()
}

class ExpandableLabelViewController: UIViewController {

    weak var delegate: ExpandableLabelViewControllerDelegate?

    private let textView = UITextView()
    
    private var shortText: String
    private var fullText: String
    private var isExpanded = false
    
    init(shortText: String, fullText: String) {
        self.shortText = shortText
        self.fullText = fullText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTextView()
        updateTextView()
    }
    
    private func setupTextView() {
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainerInset = .zero
        textView.textContainer.lineFragmentPadding = 0
        textView.delegate = self
        textView.font = UIFont(name: UIFont.SFPro.mediumM.rawValue, size: 15)
        textView.isUserInteractionEnabled = true
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(0)
            make.leading.equalTo(view.snp.leading).offset(0)
            make.trailing.equalTo(view.snp.trailing).offset(0)
        }
    }
    
    private func updateTextView() {
        let text = isExpanded ? fullText : shortText
        let moreOrLessText = isExpanded ? "  Less" : "  More"
        
        let attributedString = NSMutableAttributedString(string: text, attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
        
        let moreOrLessAttributedString = NSMutableAttributedString(
            string: moreOrLessText,
            attributes: [.foregroundColor: UIColor.blue, .font: UIFont.systemFont(ofSize: 14)]
        )
        
        moreOrLessAttributedString.addAttribute(.link, value: "toggleText", range: NSRange(location: 0, length: moreOrLessAttributedString.length))
        
        attributedString.append(moreOrLessAttributedString)
        
        textView.attributedText = attributedString
        textView.linkTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        
        delegate?.didUpdateHeight()
    }
    
    func requiredHeight() -> CGFloat {
        return isExpanded ? 320.0 : 55.0
    }
    
    @objc private func toggleText() {
        isExpanded.toggle()
        updateTextView()
    }
}

extension ExpandableLabelViewController: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        if URL.absoluteString == "toggleText" {
            toggleText()
            return false
        }
        return true
    }
}
