//
//  ForceTouchWrapper.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 20.08.24.
//

import SwiftUI
import UIKit

struct ForceTouchWrapper: UIViewControllerRepresentable {
    var onDelete: () -> Void

    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let interaction = UIContextMenuInteraction(delegate: context.coordinator)
        viewController.view.addInteraction(interaction)
        viewController.view.backgroundColor = .clear 
        return viewController
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(onDelete: onDelete)
    }

    class Coordinator: NSObject, UIContextMenuInteractionDelegate {
        var onDelete: () -> Void

        init(onDelete: @escaping () -> Void) {
            self.onDelete = onDelete
        }

        func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
            return UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
                self.makeContextMenu()
            }
        }

        func makeContextMenu() -> UIMenu {
            let deleteAction = UIAction(
                title: "Delete Card",
                image: UIImage(systemName: "trash"),
                attributes: .destructive
            ) { _ in
                self.onDelete()
            }
            return UIMenu(title: "", children: [deleteAction])
        }
    }
}
