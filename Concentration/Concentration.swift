//
//  Concentration.swift
//  Concentration
//
//  Created by Olivia Brown on 4/7/18.
//  Copyright © 2018 Olivia Brown. All rights reserved.
//

import Foundation

struct Concentration {
    
    private(set) var cards = [ConcentrationCard]()
    private var knownCards = [Int]()
    
    private(set) var flipCount = 0
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter() { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
            dateOfPreviousMove = Date()
        }
    }
    private var dateOfPreviousMove: Date?
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at \(index): chosen index not in cards")
        if !cards[index].isMatched, !cards[index].isFaceUp  {
            flipCount += 1
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, let firstDate = dateOfPreviousMove, matchIndex != index {
                if cards[matchIndex] == cards[index] {
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
        assert(numbersOfPairsOfCards > 0, "Concentration.init(\(numbersOfPairsOfCards): number of pairs of cards <= 0")
        for _ in 1...numbersOfPairsOfCards {
            let card = ConcentrationCard()
            cards += [card, card]
        }
        for index in cards.indices {
            let randomIndex = Int(arc4random_uniform(UInt32(cards.count)))
            cards.swapAt(index, randomIndex)
        }
    }
    
    mutating func restart() {
        flipCount = 0
        score = 0
        knownCards.removeAll()
        for index in cards.indices  {
            cards[index].isFaceUp = false
            cards[index].isMatched = false
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
