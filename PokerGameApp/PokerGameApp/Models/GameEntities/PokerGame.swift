//
//  PokerGame.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/13/24.
//

import Foundation

enum HandRank: Int {
    case highCard = 0, onePair, twoPairs, threeOfAKind, straight, fourOfAKind
}

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
    private var allInfos: [(String, [String])] = []
    var winner: String = ""
    
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
            player.evaluateHand()
        }
        
        winner = determineWinner(players: players)!.name
        print(winner)
    }
    
    func getDealerInfo() -> (String, [String]) {
        allInfos.append( (dealer.name, dealer.cardsDescriptions()))
        return (dealer.name, dealer.cardsDescriptions())
    }
    
    func getPlayersInfo() -> ([String], [[String]]) {
        allInfos.append( (dealer.name, dealer.cardsDescriptions()))
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
    
    private func determineWinner(players: [PokerPlayer]) -> PokerPlayer? {
        let sortedPlayers = players.sorted {
            if $0.handRank.rawValue == $1.handRank.rawValue {
                return $0.highCard > $1.highCard
            }
            return $0.handRank.rawValue > $1.handRank.rawValue
        }
        
        return sortedPlayers.first
    }
}
