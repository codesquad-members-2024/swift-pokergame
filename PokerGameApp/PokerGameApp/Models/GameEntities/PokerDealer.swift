//
//  PokerDealer.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/13/24.
//

import Foundation


class PokerDealer: CardHolder {
    var name: String = "딜러"
    var cards: [PokerCard] = []
    var cardDeck = CardDeck()
    
    init() {
        cardDeck.reset()
    }
    
    func receive(cards: [PokerCard]) {
        self.cards.append(contentsOf: cards)
    }
    
    func cardsDescriptions() -> [String] {
        return cards.map { $0.description }
    }
    

    func shuffleDeck() {
        _ = cardDeck.shuffle()
    }

    func dealCards(count: Int) -> [PokerCard]? {
        var dealCards: [PokerCard] = []
        
        for _ in 0..<count {
            if let card = cardDeck.removeOne() {
                dealCards.append(card)
            }
        }
        
        return dealCards
    }
}

