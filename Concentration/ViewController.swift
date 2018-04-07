//
//  ViewController.swift
//  Concentration
//
//  Created by Olivia Brown on 4/7/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var flipCountLabel: UILabel!
    @IBOutlet var cardButtons: [UIButton]!
    
    lazy var game = Concentration(numbersOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        }
        else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
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
    }
    
    let themes = [
        Theme(name: "Animals",
              emojiChoices:["🦓", "🦒", "🦔", "🐂", "🐑", "🐒", "🐖", "🐓"],
              backgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)),
        Theme(name: "Sports",
              emojiChoices:["🏈", "🏀", "🎾", "⚽️", "🏐", "⚾️", "🎳", "⛸"],
              backgroundColor: #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)),
        Theme(name: "Smiles",
              emojiChoices:["😀", "😁", "😂", "😃", "😄", "😊", "🙂", "☺️"],
              backgroundColor: #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)),
        Theme(name: "Cats",
              emojiChoices:["😸", "😹", "😺", "😻", "😼", "😽", "😿", "🙀"],
              backgroundColor: #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)),
        Theme(name: "Hearts",
              emojiChoices:["💕", "💓", "💖", "💗", "💘", "💝", "💞", "❣️"],
              backgroundColor: #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.6670553684, green: 0.4118469357, blue: 0.8984902501, alpha: 1)),
        Theme(name: "Ocean",
              emojiChoices:["🐠", "🏖", "🏝", "⛵️", "🐋", "🐬", "🦀", "🐚"],
              backgroundColor: #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1),
              cardBackgroundColor: #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1))
    ]
    
    var theme: Theme?
    var emojiChoices = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
    }
    
    var emojiDictionary = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emojiDictionary[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emojiDictionary[card.identifier] = emojiChoices.remove(at: randomIndex)
        }
        return emojiDictionary[card.identifier] ?? "?"
    }
    
    func setTheme() {
        emojiDictionary.removeAll()
        theme = themes[(Int(arc4random_uniform(UInt32(themes.count))))]
        emojiChoices = theme!.emojiChoices
        view.backgroundColor = theme!.backgroundColor
        
        for button in cardButtons {
            button.backgroundColor = theme!.cardBackgroundColor
        }
    }
    
    @IBAction func startNewGame(_ sender: UIButton) {
        game.restart()
        setTheme()
        updateViewFromModel()
    }
}

