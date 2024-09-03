//
//  AuthorizationViewController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 23.04.24.
//

import UIKit
import SnapKit

class RegistrationViewController: UIViewController, UITextFieldDelegate {
    let imageViewLogo = UIImageView(image: UIImage(named: "BR_logo"))
    
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 30
        view.layer.masksToBounds = true
        return view
    }()
    
    private let animatedGradientView: AnimatedGradientView = {
        let view = AnimatedGradientView(frame: UIScreen.main.bounds)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Name:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: UIFont.SFPro.regular.rawValue, size: 14)
        label.textColor = .blue
        return label
    }()
    
    let nameTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter your name"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "Phone Number:"
        label.font = UIFont(name: UIFont.SFPro.regular.rawValue, size: 14)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let phoneTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "Enter your phone number"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let dobLabel: UILabel = {
        let label = UILabel()
        label.text = "Date of Birth:"
        label.font = UIFont(name: UIFont.SFPro.regular.rawValue, size: 14)
        label.textColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dobTextField: CustomTextField = {
        let textField = CustomTextField()
        textField.placeholder = "DD/MM/YYYY"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    let signUpButton: CustomButton = {
        let button = CustomButton()
        button.setTitle("Create Account", for: .normal)
        button.addTarget(self, action: #selector(createAccountButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - Setup Constraints
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientMainView()
        setupSubViews()
        setupThemeUI()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func createAccountButtonTapped() {
        guard let name = nameTextField.text,
              let phoneNumber = phoneTextField.text,
              let dob = dobTextField.text else {
            return
        }
        
        guard !name.isEmpty, !phoneNumber.isEmpty, !dob.isEmpty else {
            showAlert(message: "Please fill in all fields.")
            return
        }
        
        let newAccount = UserPersonalInformation(name: name, phoneNumber: phoneNumber, dateOfBirth: dob)
        let newCard = BankCardInformation(user: newAccount)
        CardManager.shared.addCard(newCard)
        
        showAlert(message: "Registration successful.") {
            let initialViewController = MainMenuViewController(userInfo: newAccount)
            self.navigationController?.pushViewController(initialViewController, animated: true)
        }
    }
    
    func showAlert(message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
            completion?()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Setup Views
    
    private func setupSubViews() {
        view.addSubview(containerView)
        [imageViewLogo, nameLabel, nameTextField, phoneLabel, phoneTextField, dobLabel, dobTextField, signUpButton].forEach { containerView.addSubview($0) }
        
        
        containerView.snp.makeConstraints { maker in
            maker.centerX.equalTo(view)
            maker.height.equalTo(570)
            maker.width.equalTo(320)
            maker.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).inset(100)
        }
        
        imageViewLogo.snp.makeConstraints { maker in
            maker.width.equalTo(240)
            maker.height.equalTo(128)
            maker.leading.equalTo(self.containerView.snp.leading).inset(40)
            maker.top.equalTo(self.containerView.snp.top).inset(18)
        }
        
        nameLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.containerView.snp.leading).inset(25)
            maker.height.equalTo(22)
            maker.width.equalTo(345)
            maker.top.equalTo(self.imageViewLogo.snp.bottom).offset(25)
        }
        
        nameTextField.snp.makeConstraints { maker in
            maker.width.equalTo(230)
            maker.height.equalTo(35)
            maker.leading.equalTo(self.containerView.snp.leading).inset(25)
            maker.top.equalTo(self.nameLabel.snp.bottom).offset(-5)
        }
        
        phoneLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.containerView.snp.leading).inset(25)
            maker.height.equalTo(22)
            maker.width.equalTo(345)
            maker.top.equalTo(self.nameTextField.snp.bottom).offset(25)
        }
        
        phoneTextField.snp.makeConstraints { maker in
            maker.leading.equalTo(self.containerView.snp.leading).inset(25)
            maker.height.equalTo(35)
            maker.width.equalTo(230)
            maker.top.equalTo(self.phoneLabel.snp.bottom).offset(-5)
        }
        
        dobLabel.snp.makeConstraints { maker in
            maker.leading.equalTo(self.containerView.snp.leading).inset(25)
            maker.top.equalTo(self.phoneTextField.snp.bottom).offset(25)
            maker.height.equalTo(22)
            maker.width.equalTo(345)
        }
        
        dobTextField.snp.makeConstraints { maker in
            maker.leading.equalTo(self.containerView.snp.leading).inset(25)
            maker.top.equalTo(self.dobLabel.snp.bottom).offset(-5)
            maker.height.equalTo(35)
            maker.width.equalTo(230)
        }
        
        signUpButton.snp.makeConstraints { maker in
            maker.bottom.equalTo(self.containerView.snp.bottom).inset(30)
            maker.leading.equalTo(self.containerView.snp.leading).inset(15)
            maker.height.equalTo(53)
            maker.width.equalTo(289)
        }
    }
    
    private func setupThemeUI() {
        containerView.backgroundColor = .white
        imageViewLogo.contentMode = .scaleAspectFit
    }
    
    private func gradientMainView() {
        let gradientView = AnimatedGradientView(frame: view.bounds)
        view.insertSubview(gradientView, at: 0)
    }
}

extension RegistrationViewController {
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
