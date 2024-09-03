//
//  Transformer.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 12.05.24.
//

import SwiftUI

struct SwiftuiToUiKitTransofermer: UIViewRepresentable {
    
    
    let cardVerticalView: CardVerticalView
    let cardView: CardView
    let backgroundGradient: GradientView
    let isHorizontal: Bool

    func makeCardUIView(context: Context) -> UIView {
        if isHorizontal {
            let view = UIHostingController(rootView: cardView).view!
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        } else {
            let view = UIHostingController(rootView: cardVerticalView).view!
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIHostingController(rootView: backgroundGradient).view!
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        // No updates
    }
}
