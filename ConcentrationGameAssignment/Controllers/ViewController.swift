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
    
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    var concentrationGame: ConcentrationGame?
    
    var theme: Theme?
    
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var scoreCount: Int = 0 {
        didSet {
            scoreCountLabel.text = "Score: \(scoreCount)"
        }
    }
    
    var emoji: Dictionary<String, String> = Dictionary<String, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.concentrationGame = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        self.theme = Theme()
    }
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            sender.isUserInteractionEnabled = false
            concentrationGame?.selectCard(at: cardNumber)
            updateViewFromModel()
            updateLabels(at: cardNumber)
        }
    }
        
    @IBAction func setNewGame(_ sender: UIButton) {
        self.concentrationGame = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        self.theme = Theme()
        self.flipCount = 0
        self.scoreCount = 0
        resetView()
    }
    
    func updateViewFromModel() -> Void {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = concentrationGame!.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                if(concentrationGame?.isEnded == true) {
                    button.setTitle("", for: UIControlState.normal)
                }
            } else {
                button.setTitle("", for: UIControlState.normal)
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
    
    func updateLabels(at cardNumber: Int) -> Void {
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
    
    func resetView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            button.isUserInteractionEnabled = true
            button.setTitle("", for: UIControlState.normal)
             button.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    func getEmoji(for card: Card) -> String {
        let emojiThemeCount = theme!.emojies.count
        if emoji[card.uuid] == nil, emojiThemeCount > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiThemeCount)))
            emoji[card.uuid] = theme!.emojies.remove(at: randomIndex)
        }
        return emoji[card.uuid] ?? "?"
    }
    
}

