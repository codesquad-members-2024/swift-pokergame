//
//  CardDeck.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/12/24.
//

import Foundation

struct CardDeck {
    private var cards: [PokerCard] = []
    
    var count: Int {
        return cards.count
    }
    
    // 인스턴스 생성할 때 카드준비한다.
    init() {
        reset()
    }
    
    // 값 타입인 구조체에서 메소드 내에서 프로퍼티를 수정하기 위해 mutating키워드 사용
    mutating func reset() {
        cards.removeAll()
        
        // enum의 case값들을 순회할 수 있도록 CaseIterable 프로토콜 채택해야 함.
        Suit.allCases.forEach { suit in
            Rank.allCases.forEach { rank in
                cards.append(PokerCard(suit: suit, rank: rank))
            }
        }
    }
    
//    for i from n−1 down to 1 do
//    j ← random integer such that 0 ≤ j ≤ i
//    exchange a[j] and a[i]
    mutating func shuffle() {
        for i in stride(from: cards.count - 1, to: 1, by: -1) {
            let j = Int.random(in: 0...i)
            cards.swapAt(i, j)
        }
    }
    
    // 제거할 카드가 없는 경우에 있기 때문에 리턴을 옵셔널 값으로 함.
    mutating func removeOne() -> PokerCard? {
        guard !cards.isEmpty else { return nil }
        return cards.removeFirst()
    }
}
