//
//  PokerPlayer.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/13/24.
//

import Foundation

class PokerPlayer {
    var name: String
    var playerCards: [PokerCard] = []
    
    init(name: String) {
        self.name = name
    }
    
    func receive(cards: [PokerCard]) {
        playerCards.append(contentsOf: cards)
    }
}
