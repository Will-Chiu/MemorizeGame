//
//  EmojiMemoryGameViewModel.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 9/2/2022.
//

import SwiftUI

class EmojiMemoryGameViewModel: ObservableObject {
    static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚡", "🚠", "🚟", "🚃", "🚋", "🚅", "🚂"]
    
    static func createModel() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairOfCard: 8) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    @Published private var model = createModel()
    
    var cards: [MemoryGameModel<String>.Card] {
        return model.cards
    }
    
    // MARK: - User Intent
    
    func choose(_ card: MemoryGameModel<String>.Card) {
        model.choose(card)
    }
}

