//
//  Concentration.swift
//  Concentration
//
//  Created by Olivia Brown on 4/7/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    private var knownCards = [Int]()
    
    private(set) var flipCount = 0
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            var foundIndex: Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index
                    }
                    else {
                        return nil
                    }
                }
            }
            return foundIndex
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            dateOfPreviousMove = Date()
        }
    }
    private var dateOfPreviousMove: Date?
    
    func chooseCard(at index: Int) {
        if !cards[index].isMatched, !cards[index].isFaceUp  {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, let firstDate = dateOfPreviousMove, matchIndex != index {
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    print(firstDate.timeIntervalSinceNow)
                    score += (2 * Int(5.0/(abs(firstDate.timeIntervalSinceNow))))
                }
                else {
                    if knownCards.contains(index) {
                        score -= 1
                    }
                    if knownCards.contains(matchIndex) {
                        score -= 1
                    }
                    else {
                        knownCards += [index, matchIndex]
                    }
                }
                cards[index].isFaceUp = true
            }
            else {
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
        knownCards.removeAll()
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
}
