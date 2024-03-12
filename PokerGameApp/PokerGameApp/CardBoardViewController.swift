//
//  CardBoardViewController.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/11/24.
//

import UIKit

class CardBoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        let sample1 = PokerCard(suit: .hearts, rank: .queen)
        let sample2 = PokerCard(suit: .spades, rank: .seven)
        
        print(sample1.describe())
        print(sample2.describe())
    }
}

private extension CardBoardViewController {
    func setupView() {
        guard let patternImage = UIImage(named: "bg_pattern") else {
            return
        }
        view.backgroundColor = UIColor(patternImage: patternImage)
        
        let totalCards = 7
        let cardAspectRatio: CGFloat = 1.27
        let stackViewSpacing: CGFloat = 10.0
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = stackViewSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for _ in 0..<totalCards {
            let cardImageView = UIImageView()
            cardImageView.image = UIImage(named: "card-back")
            cardImageView.contentMode = .scaleAspectFit
            cardImageView.clipsToBounds = true
            stackView.addArrangedSubview(cardImageView)
        }
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: cardAspectRatio / CGFloat(totalCards)) // 스택 뷰의 높이를 그 너비의 약 1/7에 해당하는 1.27배로 설정해야 함
        ])
    }
}




