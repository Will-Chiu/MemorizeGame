//
//  EmojiMemoryGameViewModel.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 9/2/2022.
//

import SwiftUI

class EmojiMemoryGameViewModel {
    static let emojis = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒", "🚐", "🛻", "🚚", "🚛", "🚜", "🛵", "🏍", "🛺", "🚡", "🚠", "🚟", "🚃", "🚋", "🚅", "🚂"]
    
    static func createModel() -> MemoryGameModel<String> {
        MemoryGameModel<String>(numberOfPairOfCard: 4) { pairIndex in
            emojis[pairIndex]
        }
    }
    
    private var model = createModel()
    
    var cards: [MemoryGameModel<String>.Card] {
        return model.cards
    }
    
}

