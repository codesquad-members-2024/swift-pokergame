//
//  CardDeck.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/12/24.
//

import Foundation

struct CardDeck: Equatable {
    var cards: [PokerCard] = []
    
    /// 인스턴스 생성할 때 카드준비한다.
    init() {
        reset()
    }
    
    mutating func reset() {
        cards.removeAll()
        
        // enum의 case값들을 순회할 수 있도록 CaseIterable 프로토콜 채택해야 함.
        Suit.allCases.forEach { suit in
            Rank.allCases.forEach { rank in
                cards.append(PokerCard(suit: suit, rank: rank))
            }
        }
    }
    
    /**
     shuffle 처리하기 위해 Fisher-Yates알고리즘을 이용한 배열 섞기
     > 배열의 마지막 요소와 선택된 무작위 요소를 교환한다. 이 과정을 배열 전체에 대해 반복하여 배열을 섞는다.
     - 작동 방식:
     1. 인덱스 i를 배열의 마지막 인덱스(n-1)로 설정한다.
     2. i가 1보다 크거나 같은 동안 다음을 반복한다:
     1. 0부터 i 사이에서 무작위 인덱스 j를 선택한다.
     2. 배열의 i번째 요소와 j번째 요소를 교환한다.
     3. i를 1 감소한다.
     - 왜 이 방식을 선택? Fisher-Yates 알고리즘은 단순하면서도 효율적인 셔플 방식을 제공한다.
     - 어디서 알게 되었나? [Fisher-Yates위키백과](https://en.wikipedia.org/wiki/Fisher%E2%80%93Yates_shuffle)
     */
    mutating func shuffle() -> [PokerCard] {
        for i in stride(from: cards.count - 1, to: 1, by: -1) {
            let j = Int.random(in: 0...i)
            cards.swapAt(i, j)
        }
        return cards
    }
    
    mutating func removeOne() -> PokerCard? {
        guard !cards.isEmpty else { return nil }
        return cards.removeFirst()
    }
    
    static func == (lhs: CardDeck, rhs: CardDeck) -> Bool {
        guard lhs.cards.count == rhs.cards.count else { return false }
       
        return lhs.cards == rhs.cards
    }
}
