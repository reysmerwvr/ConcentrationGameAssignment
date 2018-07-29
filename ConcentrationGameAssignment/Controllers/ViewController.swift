//
//  ViewController.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/8/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    lazy var concentrationGame: ConcentrationGame = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
            print(flipCount)
        }
    }
    
    var emojiThemes: Dictionary<String, Array<String>> = [
        "faces" : ["😀", "😊", "😙", "🤓", "🙁", "😠", "😡", "😱"]
    ]
    
    var emoji: Dictionary<String, String> = Dictionary<String, String>()
    
    @IBAction func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            concentrationGame.selectCard(at: cardNumber)
            updateViewFromModel()
        }
    }
    
    func updateViewFromModel() -> Void {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = concentrationGame.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    func getEmoji(for card: Card) -> String {
        var emojiTheme = emojiThemes["faces"]
        let emojiThemeCount = emojiTheme!.count
        if emoji[card.uuid] == nil, emojiThemeCount > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemeCount)))
            emoji[card.uuid] = emojiTheme!.remove(at: randomIndex)
        }
        return emoji[card.uuid] ?? "?"
    }
    
}

