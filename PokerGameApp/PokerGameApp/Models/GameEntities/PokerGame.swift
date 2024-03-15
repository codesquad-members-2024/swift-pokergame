//
//  PokerGame.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/13/24.
//

import Foundation

enum GameType: Int {
    case sevenCard = 7
    case fiveCard = 5
}

enum PlayerType: Int {
    case two = 2
    case three = 3
    case four = 4
}

class PokerGame {
    private var dealer = PokerDealer()
    private var players: [PokerPlayer] = []
    private var gameType: GameType
    
    init(gameType: GameType, playerCount: PlayerType) {
        self.gameType = gameType
        let playerNames = makeRandomName(count: playerCount.rawValue)
        self.players = playerNames.map { PokerPlayer(name: $0) }
    }
    
    private func makeRandomName(count: Int) -> [String] {
        let names = ["JK", "Crong", "honux",
                     "KAI", "duck", "cat",
                     "pig", "snake", "King"]
        var availableNames = names
        var selectedNames: [String] = []
        
        for _ in 0..<count {
            if let randomName = availableNames.randomElement() {
                selectedNames.append(randomName)
                availableNames.removeAll { $0 == randomName }
            }
        }
        
        return selectedNames
    }
    
    func startGame() {
        let cardCount = gameType.rawValue
        
        dealer.shuffleDeck()
        
        distributeCards(to: dealer, cardCount: cardCount)
        for player in players {
            distributeCards(to: player, cardCount: cardCount)
        }
    }
    
    func getDealerInfo() -> (String, [String]) {
        return (dealer.name, dealer.cardsDescriptions())
    }
    
    func getPlayersInfo() -> ([String], [[String]]) {
        return (players.map { $0.name }, players.map { $0.cardsDescriptions() })
    }
    
    private func distributeCards(to cardHolder: CardHolder, cardCount: Int) {
        let cards = dealer.dealCards(count: cardCount) ?? []
        cardHolder.receive(cards: cards)
    }
    
    func uniquePlayerNamesCount() -> Int {
        let names = players.map { $0.name }
        let uniqueNames = Set(names)
        return uniqueNames.count
    }
}
