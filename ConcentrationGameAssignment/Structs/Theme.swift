//
//  Theme.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/29/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct Theme {
    var name: String
    var emojies: Array<String> = Array<String>()
    var emojiThemes: Dictionary<String, Array<String>> = [
        "faces" : ["😀", "😊", "😙", "🤓", "🙁", "😠", "😡", "😱"],
        "sports" : ["⚽️", "🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱"],
        "animals" : ["🐶", "🐱", "🐭", "🐹", "🐰", "🦊", "🐻", "🐼"]
    ]
    
    init() {
        let randomIndex: Int = Int(arc4random_uniform(UInt32(emojiThemes.count)))
        let emojiThemeKeysArray = Array(emojiThemes.keys)
        let selectedThemeName = emojiThemeKeysArray[randomIndex]
        self.name = selectedThemeName
        self.emojies = emojiThemes[selectedThemeName]!
    }
}
