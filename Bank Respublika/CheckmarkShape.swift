//
//  CheckmarkShape.swift
//  Bank Respublika
//
//  Created by Rustin Wilde on 19.08.24.
//

import SwiftUI

struct CheckmarkShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let width = rect.width
        let height = rect.height
        
        path.move(to: CGPoint(x: width * 0.2, y: height * 0.5))
        
        path.addLine(to: CGPoint(x: width * 0.4, y: height * 0.7))
        path.addLine(to: CGPoint(x: width * 0.8, y: height * 0.3))
        
        return path
    }
}

struct SuccessAnimationView: View {
    @State private var drawCircle = false
    @State private var showCheckmark = false
    @State private var showLabel = false
    @State private var showHomeButton = false
    var onHomeButtonTapped: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            
            ZStack {
                Circle()
                    .trim(from: 0, to: drawCircle ? 1 : 0)
                    .stroke(Color.green, lineWidth: 5)
                    .frame(width: 100, height: 100)
                    .rotationEffect(.degrees(-90))
                    .animation(.easeInOut(duration: 1.0), value: drawCircle)
                    .onAppear {
                        drawCircle = true
                    }
                
                CheckmarkShape()
                    .trim(from: 0, to: showCheckmark ? 1 : 0)
                    .stroke(Color.green, lineWidth: 5)
                    .frame(width: 50, height: 50)
                    .animation(.easeInOut(duration: 0.5).delay(1.0), value: showCheckmark)
                    .onAppear {
                        showCheckmark = true
                    }
            }
            
            Text("Successful Transaction")
                .font(Font.custom("Montserrat-SemiBold", size: 22))
                .foregroundColor(.green)
                .opacity(showLabel ? 1 : 0)
                .offset(y: showLabel ? 10 : 20)
                .animation(.easeInOut(duration: 0.5).delay(1.5), value: showLabel)
                .onAppear {
                    showLabel = true
                }
            
            Spacer()
            
            if showHomeButton {
                Button(action: {
                    onHomeButtonTapped()
                }) {
                    Text("Home")
                        .font(.custom("Montserrat-SemiBold", size: 18))
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(8)
                }
                .padding(.horizontal)
                .padding(.bottom, 20)
                .transition(.opacity)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    showHomeButton = true
                }
            }
        }
    }
}

class SuccessAnimationHostingController: UIHostingController<SuccessAnimationView> {
    private weak var navController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navController = navigationController
        
        let dummyClosure: () -> Void = {}
        let successAnimationView = SuccessAnimationView(onHomeButtonTapped: dummyClosure)
        
        super.init(rootView: successAnimationView)
        
        let onHomeButtonTapped: () -> Void = { [weak self] in
            self?.navigateToMainMenu()
        }
        
        self.rootView = SuccessAnimationView(onHomeButtonTapped: onHomeButtonTapped)
    }
    
    @objc required dynamic init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func navigateToMainMenu() {
        guard let navController = self.navController else { return }
        
        if let mainMenuVC = navController.viewControllers.first(where: { $0 is MainMenuViewController }) as? MainMenuViewController {
            navController.popToViewController(mainMenuVC, animated: true)
        } else {
           return
        }
    }
}

