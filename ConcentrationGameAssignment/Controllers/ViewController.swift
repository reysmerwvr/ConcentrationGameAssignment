//
//  ViewController.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/8/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var flipCountLabel: UILabel! {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    @IBOutlet private weak var scoreCountLabel: UILabel!
    
    private var concentrationGame: ConcentrationGame?
    
    private var theme: Theme?
    
    private(set) var flipCount: Int = 0 {
        didSet {
            updateFlipCountLabel()
        }
    }
    
    private(set) var scoreCount: Int = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    private var emoji: Dictionary<Card, String> = Dictionary<Card, String>()
    
    private var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concentrationGame = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
        self.theme = Theme()
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth : 3.0,
            .strokeColor : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        ]
        let attributedString = NSAttributedString(
            string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBAction private func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            sender.isUserInteractionEnabled = false
            concentrationGame?.selectCard(at: cardNumber)
            updateViewFromModel()
            updateLabels(at: cardNumber)
        }
    }
        
    @IBAction private func setNewGame(_ sender: UIButton) {
        self.concentrationGame = ConcentrationGame(numberOfPairsOfCards: numberOfPairsOfCards)
        self.theme = Theme()
        self.flipCount = 0
        self.scoreCount = 0
        resetView()
    }
    
    private func updateViewFromModel() -> Void {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = concentrationGame!.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControl.State.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                if(concentrationGame?.isEnded == true) {
                    button.setTitle("", for: UIControl.State.normal)
                }
            } else {
                button.setTitle("", for: UIControl.State.normal)
                if(card.isMatched) {
                    button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                    button.isUserInteractionEnabled = false
                } else {
                    button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
                    button.isUserInteractionEnabled = true
                }
            }
        }
    }
    
    private func updateLabels(at cardNumber: Int) -> Void {
        let card = concentrationGame!.cards[cardNumber]
        if(!card.isMatched) {
            flipCount += 1
            if(card.seenCount > 1 && scoreCount > 0) {
                scoreCount = scoreCount - 1
            }
        } else {
            scoreCount += 2
        }
    }
    
    private func resetView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.isUserInteractionEnabled = true
            button.setTitle("", for: UIControl.State.normal)
             button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    private func getEmoji(for card: Card) -> String {
        let emojiThemeCount = theme!.emojies.count
        if emoji[card] == nil, emojiThemeCount > 0 {
            emoji[card] = theme!.emojies.remove(at: emojiThemeCount.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
    }
}

