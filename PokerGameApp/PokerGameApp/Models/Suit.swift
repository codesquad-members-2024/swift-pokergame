//
//  Suit.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/12/24.
//

import Foundation

// 카드 모양이라는 관련된 값들을 그룹으로 정의하기 위해서 enum을 사용
enum Suit: String, CaseIterable, CustomStringConvertible {
    case hearts = "h" // ♥️
    case diamonds = "d" // ♦️
    case clubs = "c" // ♣️
    case spades = "s" // ♠️
    
    var description: String {
        return self.rawValue
    }
}
