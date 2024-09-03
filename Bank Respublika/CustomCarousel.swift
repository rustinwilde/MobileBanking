//
//  CustomCarousel.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 09.08.24.
//

import SwiftUI

struct CustomCarousel <Content: View, Data: RandomAccessCollection>: View where Data.Element: Identifiable {
    var config: Config
    @Binding var selection: Data.Element.ID?
    var data: Data
    @ViewBuilder var content: (Data.Element) -> Content
    var body: some View {
        GeometryReader {
            let size = $0.size
                        
            ScrollView(.horizontal) {
                HStack(spacing: 100) {
                    ForEach(data) { item in
                        ItemView(item)
                    }
                }
                .scrollTargetLayout()
            }
            .safeAreaPadding(.horizontal, max((size.width - config.cardWidth) / 2, 0))
            .scrollPosition(id: $selection)
            .scrollTargetBehavior(.viewAligned(limitBehavior: .always))
            .scrollIndicators(.hidden)
        }
    }
    
    @ViewBuilder
    func ItemView(_ item: Data.Element) -> some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minX = proxy.frame(in: .scrollView(axis: .horizontal)).minX
            let progress = abs(minX) / (config.cardWidth + config.spacing)
            
            let scaleValue = config.scaleValue * progress
            let opacityValue = config.opacityValue * progress

            content(item)
                .frame(width: config.cardWidth, height: size.height)
                .opacity(config.hasOpacity ? 1 - opacityValue : 1)
                .scaleEffect(config.hasScale ? 1 - scaleValue : 1)
                .cornerRadius(config.cornerRadius)
                .overlay(
                    RoundedRectangle(cornerRadius: config.cornerRadius)
                        .stroke(Color.clear, lineWidth: 0)
                )
                .offset(x: -progress * (config.cardWidth + config.spacing) / 3.3)
                .animation(.easeOut(duration: 0.3), value: progress)
        }
        .frame(width: config.cardWidth)
    }
    
    
    struct Config
    {
        var hasOpacity: Bool = false
        var opacityValue: CGFloat = 0.5
        var hasScale: Bool = false
        var scaleValue: CGFloat = 0.2
        var cardWidth: CGFloat = 150
        var spacing: CGFloat = 10
        var cornerRadius: CGFloat = 15
        var minimumCardWidth: CGFloat = 40
    }
}


//#Preview {
//    SelectedDestinationCardHostingController()
//}
