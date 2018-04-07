//
//  Concentration.swift
//  Concentration
//
//  Created by Olivia Brown on 4/7/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var flipCount = 0
    var score = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
            }
            else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    init(numbersOfPairsOfCards: Int) {
        for _ in 1...numbersOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        for index in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(index, randomIndex)
        }
    }
    
    func restart() {
        flipCount = 0
        score = 0
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
}
