//
//  Helpers.swift
//  ConcentrationGameAssignment
//
//  Created by Reysmer Valle on 8/1/18.
//  Copyright © 2018 Reysmer Valle. All rights reserved.
//

import Foundation

func shuffleCardsArray (originalArray arrayToShuffle: Array<Card>) -> Array<Any> {
    var originalArray = arrayToShuffle
    let arrayCount = originalArray.count
    if(arrayCount <= 0) {
        return [Any]()
    }
    var shuffled = [Card]();
    for _ in 0..<arrayCount
    {
        let rand = Int(arc4random_uniform(UInt32(originalArray.count)))
        shuffled.append(originalArray[rand])
        originalArray.remove(at: rand)
    }
    return shuffled
}
