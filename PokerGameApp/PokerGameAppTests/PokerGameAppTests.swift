//
//  PokerGameAppTests.swift
//  PokerGameAppTests
//
//  Created by 조호근 on 3/11/24.
//

import XCTest
@testable import PokerGameApp

final class PokerGameAppTests: XCTestCase {
    
    func test_GameSetupPlayerNames() {
        let game = PokerGame(gameType: .sevenCard, playerCount: .four)
        
        let uniqueNames = game.uniquePlayerNamesCount()
        XCTAssertEqual(uniqueNames,4, "플레이어의 이름은 고유해야 한다.")
    }
}


