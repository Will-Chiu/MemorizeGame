//
//  MemoryGameModel.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 9/2/2022.
//

import Foundation


struct MemoryGameModel<CardContent> {
    private(set) var cards: [Card]
    
    init(numberOfPairOfCard: Int, createContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0 ..< numberOfPairOfCard {
            let content = createContent(pairIndex)
            cards.append(Card(content: content))
            cards.append(Card(content: content))
        }
    }
    
    func choose(_ card: Card) {
        
    }
    
    struct Card {
        var isFaceUp = false
        var isMatched = false
        var content: CardContent
    }
}
