//
//  Card.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/26/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct Card {
    var uuid: String
    var isFaceUp = false
    var isMatched = false
    var seenCount = 0
    
    init() {
        self.uuid = UUID().uuidString
    }
}
