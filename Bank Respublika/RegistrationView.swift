////
////  ViewController.swift
////  Bank Respublika
////
////  Created by Rustin Wilde on 23.04.24.
////
//
//import UIKit
//import SnapKit
//
//class RegistrationView: UIView {
//  // MARK: - Properties
//   
//  private let containerView: UIView = {
//      let view = UIView()
//      view.translatesAutoresizingMaskIntoConstraints = false
//      view.layer.cornerRadius = 10
//      view.layer.masksToBounds = true
//      return view
//    }()
//   
//  private let animatedGradientView: AnimatedQradientView = {
//      let view = AnimatedQradientView(frame: UIScreen.main.bounds)
//      view.translatesAutoresizingMaskIntoConstraints = false
//      return view
//    }()
//   
//  let nameLabel: UILabel = {
//    let label = UILabel()
//    label.text = "Name:"
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//  }()
//   
//  let nameTextField: UITextField = {
//    let textField = UITextField()
//    textField.placeholder = "Enter your name"
//    textField.borderStyle = .roundedRect
//    textField.translatesAutoresizingMaskIntoConstraints = false
//    return textField
//  }()
//   
//  let phoneLabel: UILabel = {
//    let label = UILabel()
//    label.text = "Phone Number:"
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//  }()
//   
//  let phoneTextField: UITextField = {
//    let textField = UITextField()
//    textField.placeholder = "Enter your phone number"
//    textField.borderStyle = .roundedRect
//    textField.translatesAutoresizingMaskIntoConstraints = false
//    return textField
//  }()
//   
//  let dobLabel: UILabel = {
//    let label = UILabel()
//    label.text = "Date of Birth:"
//    label.translatesAutoresizingMaskIntoConstraints = false
//    return label
//  }()
//   
//  let dobTextField: UITextField = {
//    let textField = UITextField()
//    textField.placeholder = "Enter your date of birth"
//    textField.borderStyle = .roundedRect
//    textField.translatesAutoresizingMaskIntoConstraints = false
//    return textField
//  }()
//   
//  let signUpButton: UIButton = {
//    let button = UIButton(type: .system)
//    button.setTitle("Sign Up", for: .normal)
//    button.translatesAutoresizingMaskIntoConstraints = false
//    return button
//  }()
//   
//  // MARK: - Initializers
//   
//  override init(frame: CGRect) {
//    super.init(frame: frame)
//    setupViews()
//  }
//   
//  required init?(coder: NSCoder) {
//    fatalError("init(coder:) has not been implemented")
//  }
//   
//  // MARK: - Setup Constraints
//   
//    private func setupViews() {
//        addSubview(animatedGradientView)
//        sendSubviewToBack(animatedGradientView)
//        addSubview(containerView)
//        
//        [nameLabel, nameTextField, phoneLabel, phoneTextField, dobLabel, dobTextField].forEach {$0.addSubview(containerView)}
//        addSubview(signUpButton)
//        
//        containerView.snp.makeConstraints { make in
//    //        make.center.equalToSuperview() // Center containerView in its superview
//            make.top.equalToSuperview().offset(165)
//            make.leading.equalToSuperview().offset(35) // Add leading space
//          //  make.trailing.equalToSuperview().offset(35) // Add trailing space
//        //    make.bottom.equalToSuperview().offset(190)
//            make.height.equalTo(400)
//            make.width.equalTo(320)
//        }
//
//        nameLabel.snp.makeConstraints { make in
//            make.top.equalTo(containerView.snp.top).offset(20)
//            make.leading.equalTo(containerView.snp.leading).offset(20)
//            // Add other constraints as needed
//        }
//
//        // Add constraints for other subviews relative to containerView
//        // ...
//
//        // Add constraints for animatedGradientView relative to superview
//        animatedGradientView.snp.makeConstraints { make in
//            make.edges.equalToSuperview()
//            // Add other constraints as needed
//        }
//    }
//   
//  // MARK: - Setup Views
//   
////  private func setupViews() {
////      addSubview(animatedGradientView)
////      sendSubviewToBack(animatedGradientView)
////      addSubview(containerView)
////      bringSubviewToFront(containerView)
////    [nameLabel, nameTextField, phoneLabel, phoneTextField, dobLabel, dobTextField, signUpButton].forEach { containerView.addSubview($0) }
////  }
//}
