//
//  Rank.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/12/24.
//

import Foundation

// 카드 숫자라는 관련된 값들을 그룹으로 정의하기 위해서 enum을 사용
enum Rank: Int, CaseIterable {
    case ace = 1, two, three, four, five, six, seven, eight, nine, ten
    case jack = 11
    case queen = 12
    case king = 13
    
    var description: String {
        switch self {
        case .ace: return "A"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        default: return String(self.rawValue)
        }
    }
}
