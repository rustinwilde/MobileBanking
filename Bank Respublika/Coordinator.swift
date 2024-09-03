//
//  Coordinator.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 26.08.24.
//

import UIKit

class Coordinator: ObservableObject {
    weak var navigationController: UINavigationController?

    func navigateToSecondViewController() {
        guard let navigationController = navigationController else { return }
        
        if navigationController.viewControllers.count > 1 {
            let secondVC = navigationController.viewControllers[1]
            navigationController.popToViewController(secondVC, animated: true)
        } else {
            return
        }
    }
}
