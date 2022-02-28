//
//  EmojiMemoryGameView.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 8/2/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    @State private var dealtCards = Set<Int>()
    
    private func deal(_ card: EmojiMemoryGameViewModel.Card) {
        dealtCards.insert(card.id)
    }
    
    private func isDealt(_ id: Int) -> Bool {
        dealtCards.contains(id)
    }
    
    var body: some View {
        VStack {
            gameBody
            shuffle
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if (card.isMatched && !card.isFaceUp) {
                // if there is no code here, which means no VIEW will be returned and the card will be removed from the AspectVGrid
                Color.clear     //  = CardView(card: card).opacity(0)
            } else if isDealt(card.id) {
                CardView(card: card)
                    .padding(4)
                    .transition(AnyTransition.asymmetric(insertion: .scale, removal: .scale).animation(.easeInOut))
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(.red)
        .onAppear {
            // Using onAppear and dealtCards otherwise there is no transition (.scale) for card show-up
            for card in viewModel.cards {
                deal(card)
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation(Animation.easeInOut(duration: 1)) {
                viewModel.shuffle()
            }
        }
    }
}

struct CardView: View {
    private typealias CVC = CardViewConstants
    let card: EmojiMemoryGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            let animation = Animation.linear(duration: CVC.animationTime).repeatForever(autoreverses: false)
            ZStack {
                PieShape(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 135 - 90))
                    .padding(CVC.circlePadding)
                    .opacity(CVC.circleOpacity)
                Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(animation, value: card.isMatched)
                    .font(contentSize(in: geometry.size))
            }.cardify(isFaceUp: card.isFaceUp, isMatched: card.isMatched)
        }
    }
    
    private func contentSize(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * CVC.scaleFactor)
    }
    
    private struct CardViewConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
        static let scaleFactor: CGFloat = 0.7
        static let circlePadding: CGFloat = 5
        static let circleOpacity: Double = 0.5
        static let animationTime: Double = 1.5
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGameViewModel()
//        let firstCard = viewModel.cards.first!
//        viewModel.choose(firstCard)
        return EmojiMemoryGameView(viewModel: viewModel)
            .preferredColorScheme(.light)
//        EmojiMemoryGameView(viewModel: viewModel)
//            .preferredColorScheme(.dark)
    }
}
