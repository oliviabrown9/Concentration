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
    private(set) var theme: ConcentrationTheme?
    private var emojiChoices = [String]()
    
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
    
    private let themes = [
        ConcentrationTheme(name: "Animals",
              emojiChoices:["🦓", "🦒", "🦔", "🐂", "🐑", "🐒", "🐖", "🐓"],
              backgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
        ConcentrationTheme(name: "Sports",
              emojiChoices:["🏈", "🏀", "🎾", "⚽️", "🏐", "⚾️", "🎳", "⛸"],
              backgroundColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),
        ConcentrationTheme(name: "Smiles",
              emojiChoices:["😀", "😁", "😂", "😃", "😄", "😊", "🙂", "☺️"],
              backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        ConcentrationTheme(name: "Cats",
              emojiChoices:["😸", "😹", "😺", "😻", "😼", "😽", "😿", "🙀"],
              backgroundColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        ConcentrationTheme(name: "Hearts",
              emojiChoices:["💕", "💓", "💖", "💗", "💘", "💝", "💞", "❣️"],
              backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.6670553684, green: 0.4118469357, blue: 0.8984902501, alpha: 1)),
        ConcentrationTheme(name: "Ocean",
              emojiChoices:["🐠", "🏖", "🏝", "⛵️", "🐋", "🐬", "🦀", "🐚"],
              backgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    private var emojiDictionary = [ConcentrationCard: String]()
    
    private func emoji(for card: ConcentrationCard) -> String {
        if emojiDictionary[card] == nil, emojiChoices.count > 0 {
            emojiDictionary[card] = emojiChoices.remove(at: emojiChoices.count.arc4random)
        }
        return emojiDictionary[card] ?? "?"
    }
    
    private func setTheme() {
        emojiDictionary.removeAll()
        theme = themes[themes.count.arc4random]
        emojiChoices = theme!.emojiChoices
        view.backgroundColor = theme!.backgroundColor
        titleLabel.text = theme!.name
        
        for button in cardButtons {
            button.backgroundColor = theme!.cardBackgroundColor
        }
    }
    
    @IBAction private func startNewGame(_ sender: UIButton) {
        game.restart()
        setTheme()
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

