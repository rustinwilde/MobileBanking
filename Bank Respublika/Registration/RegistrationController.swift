//
//  RegistrationController.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 24.04.24.
//

import UIKit

protocol RegistrationDelegate: AnyObject {
    func didTapSignUp(name: String?, phoneNumber: String?, dob: String?)
}

class RegistrationController {
    weak var delegate: RegistrationDelegate?

    func signUp(name: String?, phoneNumber: String?, dob: String?) {
        delegate?.didTapSignUp(name: name, phoneNumber: phoneNumber, dob: dob)
    }
}


