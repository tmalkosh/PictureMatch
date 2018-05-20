//
//  Card.swift
//  PictureMatch
//
//  Created by SpotHeroTareq on 4/15/18.
//  Copyright © 2018 Tareq Malkosh. All rights reserved.
//

import Foundation

struct Card
{
    var isFaceUp = false
    var isMatched = false
    var identifier: Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identifierFactory += 1
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
