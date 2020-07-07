//
//  Card.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 7/26/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

struct Card: Hashable {
    
//    var hashValue: Int { return indentifier }
    private var indentifier: Int
//    var uuid: String
    var isFaceUp = false
    var isMatched = false
    var seenCount = 0
    private static var identifierFactory = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(indentifier)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.indentifier == rhs.indentifier
    }
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        //self.uuid = UUID().uuidString
        self.indentifier = Card.getUniqueIdentifier()
    }
}
