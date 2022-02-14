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
    let card: EmojiMemoryGameViewModel.Card
    
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if card.isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3, antialiased: true)
                Text(card.content).font(.largeTitle)
            } else {
                shape.fill()
                if card.isMatched {
                    Text("✔️").font(.largeTitle).opacity(0.5)
                }
            }
        }
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
