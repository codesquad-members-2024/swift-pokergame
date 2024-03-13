//
//  PokerGameAppTests.swift
//  PokerGameAppTests
//
//  Created by 조호근 on 3/11/24.
//

import XCTest
@testable import PokerGameApp

final class PokerGameAppTests: XCTestCase {
    
    func test_CardDeckInitialization() {
        let deck = CardDeck()
        
        XCTAssertEqual(deck.cards.count, 52, "초기화된 카드덱은 52장이 되어야 한다.")
    }
    
    func test_Shuffle() {
        var deck = CardDeck()
        
        let originalDeck = deck.cards
        let shuffledDeck = deck.shuffle()
        
        XCTAssertNotEqual(originalDeck, shuffledDeck, "원본과 셔플된 덱이 달라야 한다.")
    }
    
    func test_PokerCardDescription() {
        let card = PokerCard(suit: .hearts, rank: .queen)
        
        let expectedDescription = "\u{2665}Q"
        
        XCTAssertEqual(card.description, expectedDescription, "문자열 일치해야 한다.")
    }
}


