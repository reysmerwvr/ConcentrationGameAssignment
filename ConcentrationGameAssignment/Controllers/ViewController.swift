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
    
    var concentrationGame: ConcentrationGame?
    
    var theme: Theme?
    
    var flipCount: Int = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
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
            concentrationGame?.selectCard(at: cardNumber)
            updateViewFromModel()
            let card = concentrationGame!.cards[cardNumber]
            if(!card.isMatched) {
                flipCount += 1
            }
        }
    }
        
    @IBAction func setNewGame(_ sender: UIButton) {
        self.concentrationGame = ConcentrationGame(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        self.theme = Theme()
        self.flipCount = 0
        resetView()
    }
    
    func updateViewFromModel() -> Void {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = concentrationGame!.cards[index]
            if card.isFaceUp {
                button.setTitle(getEmoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            }
        }
    }
    
    func resetView() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
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

