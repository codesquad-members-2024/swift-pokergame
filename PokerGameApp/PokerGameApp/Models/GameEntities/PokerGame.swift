//
//  PokerGame.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/13/24.
//

import Foundation

enum GameType {
    case sevenCard
    case fiveCard
}

class PokerGame {
    var dealer = PokerDealer()
    var players: [PokerPlayer] = []
    private var gameType: GameType
    
    init(gameType: GameType, playerCount: Int) {
        self.gameType = gameType
        let playerNames = makeRandomName(count: playerCount)
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
        let cardCount = (gameType == .sevenCard) ? 7 : 5
        
        dealer.shuffleDeck()
        
        for player in players {
            let cards = dealer.dealCards(count: cardCount) ?? []
            player.receive(cards: cards)
        }
        
        let cards = dealer.dealCards(count: cardCount) ?? []
        dealer.dealerCards = cards
    }
    
    func printPlayerAndDealerCards() {
        for player in players {
            print("\(player.name)의 카드: \(player.playerCards.map { $0.description }.joined(separator: ", "))")
        }
        print("딜러의 카드: \(dealer.dealerCards.map { $0.description }.joined(separator: ", "))")
    }
}
