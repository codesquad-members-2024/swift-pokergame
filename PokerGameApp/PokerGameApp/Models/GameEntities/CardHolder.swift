//
//  CardHolder.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/14/24.
//

import Foundation

protocol CardHolder {
    var name: String { get }
    var cards: [PokerCard] { get set }
    
    func receive(cards: [PokerCard])
    func cardsDescriptions() -> [String]
}
