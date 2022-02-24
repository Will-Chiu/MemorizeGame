//
//  Cardify.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 21/2/2022.
//

import SwiftUI

// There is an animatableData inside Animatable protocol, it controls the animation
struct Cardify: ViewModifier, Animatable {
    
    private typealias CVC = CardViewConstants
    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    var isFaceUp: Bool
    var isMatched: Bool
    // using rotation to control animation process instead of isFaceUp
    // ???What is the upper and lower or the rotation value???
    var rotation: Double
    
    init(isFaceUp: Bool, isMatched: Bool) {
        self.isFaceUp = isFaceUp
        self.isMatched = isMatched
        self.rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: CVC.cornerRadius)
            if rotation < 90 {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: CVC.lineWidth, antialiased: true)
            } else {
                shape.fill()
                if isMatched && !isFaceUp && rotation > 90 {
                    Text("✔️").font(.largeTitle).opacity(0.5)
                        .rotation3DEffect(Angle.degrees(180), axis: (0, 1, 0))
                }
            }
            // putting content here, because the animation only happens after the view is already on screen.
            content.opacity(rotation < 90 ? 1 : 0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (0, 1, 0))
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
