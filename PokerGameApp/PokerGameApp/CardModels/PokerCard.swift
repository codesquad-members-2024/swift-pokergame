//
//  PokerCard.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/12/24.
//

import Foundation

// 명확하게 이해하기 위해서 모양과 숫자를 독립적인 구성으로 나눴다.
class PokerCard: Equatable, CustomStringConvertible {
    var suit: Suit
    var rank: Rank
    
    init(suit: Suit, rank: Rank) {
        self.suit = suit
        self.rank = rank
    }
    
    var description: String {
        return "\(suit)\(rank)"
    }
    
    static func == (lhs: PokerCard, rhs: PokerCard) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    }
    
}

