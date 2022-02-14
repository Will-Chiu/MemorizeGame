//
//  MemoryGameModel.swift
//  MemorizeGame
//
//  Created by Entangled Mind on 9/2/2022.
//

import Foundation

struct MemoryGameModel<CardContent> where CardContent: Equatable {
    private(set) var cards: [Card]
    private var indexOfFirstCard: Int? {
        get { cards.indices.filter({ cards[$0].isFaceUp }).oneAndOnly }
        set { cards.indices.forEach { cards[$0].isFaceUp = ($0 == newValue) }}
    }
    
    init(numberOfPairOfCard: Int, createContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0 ..< numberOfPairOfCard {
            let content = createContent(pairIndex)
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }), chosenIndex != indexOfFirstCard, !cards[chosenIndex].isMatched {
            if let firstCardIndex = indexOfFirstCard {
                if cards[firstCardIndex].content == cards[chosenIndex].content {
                    cards[firstCardIndex].isMatched = true
                    cards[chosenIndex].isMatched = true
                }
            } else {
                indexOfFirstCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp = true
        }
        print(cards)
    }
    
    struct Card: Identifiable {
        let id: Int
        var isFaceUp = false
        var isMatched = false
        let content: CardContent
    }
}

extension Array {
    var oneAndOnly: Element? {
        if self.count == 1 {
            return self.first
        } else {
            return nil
        }
    }
}
