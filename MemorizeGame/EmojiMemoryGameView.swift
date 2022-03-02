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
    @Namespace private var dealCardNamesapce
    
    private func deal(_ card: EmojiMemoryGameViewModel.Card) {
        dealtCards.insert(card.id)
    }
    
    private func isDealt(_ card: EmojiMemoryGameViewModel.Card) -> Bool {
        dealtCards.contains(card.id)
    }
    
    private func dealAnimation(for card: EmojiMemoryGameViewModel.Card) -> Animation {
        var delay = 0.0
        if let index = viewModel.cards.firstIndex(where: { $0.id == card.id }) {
            delay = Double(index) * DeckConstant.totalDelaDuration / Double(viewModel.cards.count)
        }
        return Animation.easeInOut(duration: DeckConstant.dealDuration).delay(delay)
    }
    
    private func zIndex(of card: EmojiMemoryGameViewModel.Card) -> Double {
        -Double(viewModel.cards.firstIndex(where: { $0.id == card.id}) ?? 0)
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            VStack {
                deck
                Spacer().frame(height: 30.0)
                    
            }
        }
        .padding()
    }
    
    var gameBody: some View {
        AspectVGrid(items: viewModel.cards, aspectRatio: 2/3) { card in
            if (card.isMatched && !card.isFaceUp) {
                // if there is no code here, which means no VIEW will be returned and the card will be removed from the AspectVGrid
                Color.clear     //  = CardView(card: card).opacity(0)
            } else if isDealt(card) {
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealCardNamesapce)
                    .padding(4)
                    // use zIndex to align with Deck zIndex
                    .zIndex(zIndex(of: card))
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                    .onTapGesture {
                        withAnimation(Animation.easeInOut(duration: 1)) {
                            viewModel.choose(card)
                        }
                    }
            }
        }
        .foregroundColor(DeckConstant.color)
    }

    var deck: some View {
        ZStack {
            ForEach(viewModel.cards.filter{ !isDealt($0) }) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealCardNamesapce)
                    .transition(AnyTransition.asymmetric(insertion: .identity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: DeckConstant.width, height: DeckConstant.height)
        .foregroundColor(DeckConstant.color)
        .onTapGesture {
            for card in viewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealtCards = []
                viewModel.restart()
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
    
    private struct DeckConstant {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration = 0.5
        static let totalDelaDuration = 2.0
        static let height: CGFloat = 90
        static let width: CGFloat = 60
    }
}

struct CardView: View {
    private typealias CVC = CardViewConstants
    let card: EmojiMemoryGameViewModel.Card
    
    @State private var animatedBonusRemaining: Double = 0
    
    var body: some View {
        GeometryReader { geometry in
            let animation = Animation.linear(duration: CVC.animationTime).repeatForever(autoreverses: false)
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        PieShape(startAngle: Angle(degrees: 0 - 90),
                                 endAngle: Angle(degrees: (1 - animatedBonusRemaining) * 360 - 90))
                            .onAppear {
                                animatedBonusRemaining = card.bonusRemaining
                                withAnimation(.linear(duration: card.bonusTimeRemaining)) {
                                    animatedBonusRemaining = 0
                                }
                            }
                    } else {
                        PieShape(startAngle: Angle(degrees: 0 - 90),
                                 endAngle: Angle(degrees: (1 - card.bonusRemaining) * 360 - 90))
                    }
                }
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
