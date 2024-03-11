//
//  ViewController.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/11/24.
//

import UIKit

class CardBoardViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "bg_pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
            
            setupView()
        }
    }
}

private extension CardBoardViewController {
    func setupView() {
        
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
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20), // 좌측 여백
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20), // 우측 여백
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100), // 상단 여백
            stackView.heightAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: cardAspectRatio / CGFloat(totalCards))
        ])
    }
}




