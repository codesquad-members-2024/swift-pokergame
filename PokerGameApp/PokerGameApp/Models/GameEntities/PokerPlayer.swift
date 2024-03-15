//
//  PokerPlayer.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/13/24.
//

import Foundation

class PokerPlayer: CardHolder {
    var name: String
    var cards: [PokerCard] = []
    
    init(name: String) {
        self.name = name
    }
    
    func receive(cards: [PokerCard]) {
        self.cards.append(contentsOf: cards)
    }
    
    func cardsDescriptions() -> [String] {
        return cards.map { $0.description }
    }
}
