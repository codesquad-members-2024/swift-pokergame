//
//  ViewController.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "bg_pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
            
            setupView()
        }
    }
}

private extension ViewController {
    func setupView() {
        
        let availableWidth = view.bounds.width - 20 * 2 - 60 // 좌우 여백 20, 카드 사이 여백 10 * 6
        let cardWidth = availableWidth / CGFloat(7.0) // 좌우여백, 카드사이 여백 10*6뺀 나머지 가로길이에 7등분
        let cardHeight = cardWidth * CGFloat(1.27)
        
        for i in 0..<7 {
            let cardX = 20 + CGFloat(i) * (cardWidth + 10) // 각 카드의 x 좌표
            createCardImageView(x: cardX, y: 100, width: cardWidth, height: cardHeight)
        }
    }
    
    private func createCardImageView(x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        let cardImageView = UIImageView(frame: CGRect(x: x, y: y, width: width, height: height))
        cardImageView.image = UIImage(named: "card-back")
        cardImageView.contentMode = .scaleAspectFit
        view.addSubview(cardImageView)
    }
}




