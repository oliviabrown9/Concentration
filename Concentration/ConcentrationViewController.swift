//
//  ViewController.swift
//  Concentration
//
//  Created by Olivia Brown on 4/7/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    @IBOutlet private weak var scoreLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private var cardButtons: [UIButton]!
    
    private lazy var game = Concentration(numbersOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    var theme: ConcentrationTheme? {
        didSet {
            emojiChoices = theme!.emojiChoices
            view.backgroundColor = theme!.backgroundColor
            titleLabel.text = theme!.name
            
            emojiDictionary.removeAll()
            
            for button in cardButtons {
                button.backgroundColor = theme!.cardBackgroundColor
            }
        }
    }
    
    private var emojiChoices = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if theme == nil {
            theme = ConcentrationTheme(name: "Hearts",
            emojiChoices:["💕", "💓", "💖", "💗", "💘", "💝", "💞", "❣️"],
            backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
            cardBackgroundColor: #colorLiteral(red: 0.6670553684, green: 0.4118469357, blue: 0.8984902501, alpha: 1))
        }
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 1)
            }
            else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : theme!.cardBackgroundColor
            }
        }
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
    }
    
    private var emojiDictionary = [ConcentrationCard: String]()
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emojiDictionary[card] == nil, emojiChoices.count > 0 {
            emojiDictionary[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emojiDictionary[card] ?? "?"
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.restart()
        updateViewFromModel()
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        }
        else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        }
        else {
            return 0
        }
    }
}

