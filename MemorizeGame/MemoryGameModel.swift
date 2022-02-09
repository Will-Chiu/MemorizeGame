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
            cards.append(Card(id: pairIndex * 2, content: content))
            cards.append(Card(id: pairIndex * 2 + 1, content: content))
        }
    }
    
    mutating func choose(_ card: Card) {
        print("card.id: \(card.id)")
        print(cards)
        
        guard let index = findIndex(by: card) else { return }
        cards[index].isFaceUp.toggle()
    }
    
    func findIndex(by choosen: Card) -> Int? {
        for card in cards {
            if card.id == choosen.id {
                return card.id
            }
        }
        return nil
    }
    
    
    struct Card: Identifiable {
        var id: Int
        var isFaceUp = true
        var isMatched = false
        var content: CardContent
    }
}
