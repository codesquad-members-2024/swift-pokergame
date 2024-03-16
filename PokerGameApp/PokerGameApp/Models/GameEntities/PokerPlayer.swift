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
    var handRank: HandRank = .highCard
    var highCard: Int = 0
    
    init(name: String) {
        self.name = name
    }
    
    func receive(cards: [PokerCard]) {
        self.cards.append(contentsOf: cards)
    }
    
    func cardsDescriptions() -> [String] {
        return cards.map { $0.description }
    }
    
    func evaluateHand() {
        let ranks = cards.map { $0.getRank() }
        let groupedRanks = Dictionary(grouping: ranks, by: {$0}).mapValues{ $0.count }
        
        let pairs = groupedRanks.filter { $0.value == 2 }
        let threeOfAKind = groupedRanks.first(where: { $0.value == 3 })
        let fourOfAKind = groupedRanks.first(where: { $0.value == 4 })
        let sortedRanks = groupedRanks.keys.sorted()
        
        if fourOfAKind != nil {
            handRank = .fourOfAKind
            highCard = fourOfAKind!.key
        } else if threeOfAKind != nil {
            handRank = .threeOfAKind
            highCard = threeOfAKind!.key
        } else if pairs.count >= 2 {
            handRank = .twoPairs
            highCard = pairs.keys.sorted(by: >).first!
        } else if sortedRanks.count >= 5 && sortedRanks.last! - sortedRanks.first! == 4 {
            handRank = .straight
            highCard = sortedRanks.last!
        } else {
            highCard = sortedRanks.last!
        }
    }
}
