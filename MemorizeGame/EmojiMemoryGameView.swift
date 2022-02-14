//
//  EmojiMemoryGameView.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 8/2/2022.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGameViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(viewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct CardView: View {
    private typealias CVC = CardViewConstants
    let card: EmojiMemoryGameViewModel.Card
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: CVC.cornerRadius)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: CVC.lineWidth, antialiased: true)
                    Text(card.content).font(contentSize(in: geometry.size))
                } else {
                    shape.fill()
                    if card.isMatched {
                        Text("✔️").font(.largeTitle).opacity(0.5)
                    }
                }
            }
        }
    }
    
    private func contentSize(in size: CGSize) -> Font {
        Font.system(size: min(size.width, size.height) * CVC.scaleFactor)
    }
    
    private struct CardViewConstants {
        static let cornerRadius: CGFloat = 20
        static let lineWidth: CGFloat = 3
        static let scaleFactor: CGFloat = 0.7
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemoryGameViewModel()
        EmojiMemoryGameView(viewModel: viewModel)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(viewModel: viewModel)
            .preferredColorScheme(.dark)
    }
}
