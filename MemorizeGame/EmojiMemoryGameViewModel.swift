//
//  EmojiMemoryGameViewModel.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 9/2/2022.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    typealias Card = MemoryGameModel<String>.Card
    private static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚡", "🚠", "🚟", "🚃", "🚋", "🚅", "🚂"]
    
    private static func createModel() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairOfCard: 8) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createModel()
    
    var cards: [Card] {
        return model.cards
    }
    
    // MARK: - User Intent
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
}

