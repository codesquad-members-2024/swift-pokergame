//
//  CardBoardViewController.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/11/24.
//

import UIKit

class CardBoardViewController: UIViewController {
    private var segmentStackView: UIStackView!
    var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private var selectedGameType: GameType = .sevenCard
    private var selectedPlayerCount: PlayerType = .two
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let patternImage = UIImage(named: "bg_pattern") {
            view.backgroundColor = UIColor(patternImage: patternImage)
        } else {
            view.backgroundColor = .brown
        }
        
        setupSegmentControl()
        setupMainStackView()
        updateGame()
        
    }
    
    override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            updateGame()
        }
    }
    
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        setupMainStackViewConstraints()
    }

    private func setupMainStackViewConstraints() {
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            mainStackView.topAnchor.constraint(equalTo: segmentStackView.bottomAnchor, constant: 20),
        ])
    }
}

private extension CardBoardViewController {
    func setupCardsAndNameStack(with name: String, and cards: [String]) {
        
        let verticalStackViewSpacing: CGFloat = 1.0
        let cardStackViewSpacing: CGFloat = 1.0
        
        let totalCards = cards.count
        let cardAspectRatio: CGFloat = 1.27
        let availableWidth = view.bounds.width - 40
        let cardWidth = (availableWidth - (cardStackViewSpacing * CGFloat(totalCards - 1))) / CGFloat(totalCards)
        let cardHeight = cardWidth * cardAspectRatio
        
        let verticalStackView = UIStackView()
        verticalStackView.axis = .vertical
        verticalStackView.distribution = .fill
        verticalStackView.alignment = .fill
        verticalStackView.spacing = verticalStackViewSpacing
        verticalStackView.translatesAutoresizingMaskIntoConstraints = false
        
        let nameLabel = UILabel()
        nameLabel.text = name
        nameLabel.textAlignment = .left
        nameLabel.textColor = .white
        nameLabel.font = UIFont.boldSystemFont(ofSize: 16)
        
        let cardStackView = UIStackView()
        cardStackView.axis = .horizontal
        cardStackView.distribution = .fillEqually
        cardStackView.alignment = .fill
        cardStackView.translatesAutoresizingMaskIntoConstraints = false
        
        cards.forEach { description in
            let cardImageView = UIImageView()
            cardImageView.contentMode = .scaleAspectFit
            cardImageView.clipsToBounds = true
            let frontImageName = description
            
            if let frontImage = UIImage(named: frontImageName) {
                cardImageView.image = frontImage
            } else {
                cardImageView.image = UIImage(named: "card-back")
            }
            cardImageView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                cardImageView.widthAnchor.constraint(equalToConstant: cardWidth),
                cardImageView.heightAnchor.constraint(equalToConstant: cardHeight)
            ])
            cardStackView.addArrangedSubview(cardImageView)
        }
        
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(cardStackView)
        
        mainStackView.addArrangedSubview(verticalStackView)
    }
    
    func setupSegmentControl() {
        let gameTypeSegmentedControl = UISegmentedControl(items: ["7 Cards", "5 Cards"])
        let playerCountSegmentedControl = UISegmentedControl(items: ["2명", "3명", "4명"])
        
        gameTypeSegmentedControl.selectedSegmentIndex = 0
        playerCountSegmentedControl.selectedSegmentIndex = 0
        
        gameTypeSegmentedControl.addTarget(self, action: #selector(gameTypeChanged(_:)), for: .valueChanged)
        playerCountSegmentedControl.addTarget(self, action: #selector(playerCountChanged(_:)), for: .valueChanged)
        
        segmentStackView = UIStackView(arrangedSubviews: [gameTypeSegmentedControl, playerCountSegmentedControl])
        segmentStackView.axis = .vertical
        segmentStackView.distribution = .fillEqually
        segmentStackView.spacing = 10
        segmentStackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(segmentStackView)
        
        NSLayoutConstraint.activate([
            segmentStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            segmentStackView.centerYAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            segmentStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 100),
            segmentStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -100)
        ])
    }
    
    @objc func gameTypeChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedGameType = .sevenCard
        case 1:
            selectedGameType = .fiveCard
        default:
            break
        }
        updateGame()
    }
    
    @objc func playerCountChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            selectedPlayerCount = .two
        case 1:
            selectedPlayerCount = .three
        case 2:
            selectedPlayerCount = .four
        default:
            break
        }
        updateGame()
    }
    
    private func updateGame() {
        let arrangedSubviews = mainStackView.arrangedSubviews
        for subview in arrangedSubviews {
            mainStackView.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        
        let game = PokerGame(gameType: selectedGameType, playerCount: selectedPlayerCount)
        
        game.startGame()
        
        let (names, cardsArray) = game.getPlayersInfo()

        for (name, cards) in zip(names, cardsArray) {
            setupCardsAndNameStack(with: name, and: cards)
        }
        
        let (dealerName, dealerCards) = game.getDealerInfo()
        setupCardsAndNameStack(with: dealerName, and: dealerCards)
    }
}
