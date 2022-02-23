//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 21/2/2022.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    private typealias CVC = CardViewConstants
    
    var isFaceUp: Bool
    var isMatched: Bool
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: CVC.cornerRadius)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: CVC.lineWidth, antialiased: true)
            } else {
                shape.fill()
                if isMatched {
                    Text("✔️").font(.largeTitle).opacity(0.5)
                }
            }
            // putting content here, because the animation only happens after the view is already on screen.
            content.opacity(isFaceUp ? 1 : 0)
        }
    }
    
    private struct CardViewConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let scaleFactor: CGFloat = 0.7
        static let circlePadding: CGFloat = 5
        static let circleOpacity: Double = 0.5
    }
}


extension View {
    func cardify(isFaceUp: Bool, isMatched: Bool) -> some View{
        self.modifier(Cardify(isFaceUp: isFaceUp, isMatched: isMatched))
    }
}
