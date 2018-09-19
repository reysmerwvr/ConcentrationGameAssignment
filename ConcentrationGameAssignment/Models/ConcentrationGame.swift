//
//  ConcentrationGame.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/26/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct ConcentrationGame {
    
    private(set) var cards = [Card]()
    private(set) var isEnded: Bool = false
    private var numberOfMatchedCards: Int = 0
    private var numberOfPairOfCardsForMatch: Int = 0
    private var faceUpCardIndex: Int? {
        get {
            return cards.indices.filter { cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0,
               "Concentration.init(at: \(numberOfPairsOfCards)): you must at least one pair of cards")
        numberOfPairOfCardsForMatch = numberOfPairsOfCards
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = shuffleCardsArray(originalArray: cards) as! [Card]
    }
    
    mutating func selectCard(at index: Int) -> Void {
        assert(cards.indices.contains(index),
               "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        if !cards[index].isMatched {
            if let matchIndex = faceUpCardIndex, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    numberOfMatchedCards += 1
                }
                cards[index].isFaceUp = true
                cards[index].seenCount += 1
            } else {
                cards[index].isFaceUp = true
                cards[index].seenCount += 1
                faceUpCardIndex = index
            }
        }
        if(numberOfMatchedCards == numberOfPairOfCardsForMatch) {
            isEnded = true
        }
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
