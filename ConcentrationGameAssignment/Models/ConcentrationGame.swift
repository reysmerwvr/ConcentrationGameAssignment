//
//  ConcentrationGame.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/26/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

class ConcentrationGame {
    
    var cards = [Card]()
    var faceUpCardIndex: Int?
    
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        cards = shuffleCardsArray(originalArray: cards) as! [Card]
    }
    
    func selectCard(at index: Int) -> Void {
        if !cards[index].isMatched {
            if let matchIndex = faceUpCardIndex, matchIndex != index {
                if cards[matchIndex].uuid == cards[index].uuid {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
                faceUpCardIndex = nil
            } else {
                for flipDownIndex in cards.indices {
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                faceUpCardIndex = index
            }
        }
    }
}
