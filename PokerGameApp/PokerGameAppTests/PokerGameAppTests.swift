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
    
    func test_GameSetupForThreePlayers() {
        let count = 3
        
        let game = PokerGame(gameType: .sevenCard, playerCount: count)
        
        XCTAssertEqual(game.players.count, count, "초기화된 PokerGame 객체의 player수는 count와 동일해야 한다.")
    }
    
    func test_GameSetupForSevenCard() {
        let game = PokerGame(gameType: .sevenCard, playerCount: 3)
        
        game.startGame()
        
        
        for player in game.players {
            XCTAssertEqual(player.playerCards.count, 7, "플레이어의 카드 수가 게임방식에 맞게 동일해야 한다.")
        }
        
        XCTAssertEqual(game.dealer.dealCards(count: 7)?.count, 7)
    }
    
    func test_GameSetupPlayerNames() {
        let game = PokerGame(gameType: .sevenCard, playerCount: 4)
        
        let uniqueNames = Set(game.players.map { $0.name} )
        XCTAssertEqual(uniqueNames.count, game.players.count, "플레이어의 이름은 고유해야 한다.")
    }
}


