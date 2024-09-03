//
//  GradientView.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 30.07.24.
//

import SwiftUI

struct GradientView: View {
    @State private var firstLayerOffset: CGFloat = 0
    @State private var firstLayerRotation: Double = 0
    @State private var secondLayerOffset: CGFloat = 0
    @State private var secondLayerRotation: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [.blue, .indigo]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .frame(width: geometry.size.width, height: geometry.size.height + 130)
                .position(x: 340 + firstLayerOffset, y: 490 + firstLayerOffset)
                .blur(radius: 120)
                .rotationEffect(.degrees(25 + firstLayerRotation))
                
                LinearGradient(
                    gradient: Gradient(colors: [.cyan, .accentColor]),
                    startPoint: .topTrailing,
                    endPoint: .bottomLeading
                )
                .frame(width: geometry.size.width / 1.5, height: geometry.size.height * 1.5)
                .offset(x: -geometry.size.width / 1.5 + secondLayerOffset, y: -geometry.size.height / 2 + secondLayerOffset)
                .rotationEffect(.degrees(25 + secondLayerRotation))
                .blur(radius: 120)
                
            }
            .edgesIgnoringSafeArea(.all)
            .onAppear {
                withAnimation(Animation.easeInOut(duration: 20).repeatForever(autoreverses: true)) {
                    firstLayerOffset = 50
                    firstLayerRotation = 360
                }
                withAnimation(Animation.easeInOut(duration: 20).repeatForever(autoreverses: true)) {
                    secondLayerOffset = 75
                    secondLayerRotation = 360
                }
            }
        }
    }
}

struct GradientWaveView_Previews: PreviewProvider {
    static var previews: some View {
        GradientView()
    }
}
