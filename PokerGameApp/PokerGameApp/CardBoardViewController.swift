//
//  CardBoardViewController.swift
//  PokerGameApp
//
//  Created by 조호근 on 3/11/24.
//

import UIKit

class CardBoardViewController: UIViewController {
    
    private var segmentStackView: UIStackView!
    private var winner: String = ""
    
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
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60),
            mainStackView.topAnchor.constraint(equalTo: segmentStackView.bottomAnchor, constant: 20)
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
        
        for (index, card) in cards.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * 1.0) {
                let cardImageView = self.createCardImageView(with: card, cardWidth: cardWidth, cardHeight: cardHeight)
                cardStackView.addArrangedSubview(cardImageView)
            }
        }
        
        verticalStackView.addArrangedSubview(nameLabel)
        verticalStackView.addArrangedSubview(cardStackView)
        
        mainStackView.addArrangedSubview(verticalStackView)
    }
    
    func createCardImageView(with cardName: String, cardWidth: CGFloat, cardHeight: CGFloat) -> UIImageView {
        let cardImageView = UIImageView()
        cardImageView.contentMode = .scaleAspectFit
        cardImageView.clipsToBounds = true
        let frontImageName = cardName
        cardImageView.image = UIImage(named: frontImageName) ?? UIImage(named: "card-back")
        cardImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cardImageView.widthAnchor.constraint(equalToConstant: cardWidth),
            cardImageView.heightAnchor.constraint(equalToConstant: cardHeight)
        ])
        return cardImageView
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
            subview.removeFromSuperview()
        }
        view.subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
        
        let game = PokerGame(gameType: selectedGameType, playerCount: selectedPlayerCount)
        
        game.startGame()
        winner = game.winner
        
        let (names, cardsArray) = game.getPlayersInfo()

        for (name, cards) in zip(names, cardsArray) {
            setupCardsAndNameStack(with: name, and: cards)
        }
        let (dealerName, dealerCards) = game.getDealerInfo()
        setupCardsAndNameStack(with: dealerName, and: dealerCards)
        
        for subView in mainStackView.arrangedSubviews {
            if let playerStackView = subView as? UIStackView,
               let nameLabel = playerStackView.arrangedSubviews.first as? UILabel,
               nameLabel.text == winner {
                let medalImage = emojiToImage(emoji: "🥇", size: CGSize(width: 50, height: 50))
                let medalImageView = UIImageView(image: medalImage)
                medalImageView.tag = 999
                medalImageView.translatesAutoresizingMaskIntoConstraints = false
              
                view.addSubview(medalImageView)
                
                
                NSLayoutConstraint.activate([
                    medalImageView.leadingAnchor.constraint(equalTo: playerStackView.trailingAnchor, constant: 10),
                    medalImageView.centerYAnchor.constraint(equalTo: playerStackView.centerYAnchor, constant: 10)
                ])
            }
        }
    }
    
    func emojiToImage(emoji: String, size: CGSize) -> UIImage? {
        let label = UILabel()
        label.text = emoji
        label.textAlignment = .center
        label.bounds = CGRect(origin: .zero, size: size)
        label.font = UIFont.systemFont(ofSize: size.height)
        
        UIGraphicsBeginImageContextWithOptions(label.bounds.size, false, 0)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        label.layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
