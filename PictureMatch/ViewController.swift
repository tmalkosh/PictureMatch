//
//  ViewController.swift
//  PictureMatch
//
//  Created by SpotHeroTareq on 4/15/18.
//  Copyright © 2018 Tareq Malkosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    private lazy var game = pictureMatch(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
            return (cardButtons.count+1 / 2)
    }


    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBAction private func touchCard(_ sender: UIButton) {
        flipCount += 1
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            updateViewFromModel()
        } else {
            print("chosen card not in cardButtons")
        }
    }
    private func updateViewFromModel() {
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(flag(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                button.isEnabled = false
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                button.isEnabled = true
                if button.backgroundColor ==  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) {
                    button.isEnabled = false
                    
                }
            }
        }
    }
    
    private var flagChoices = ["🇩🇪","🇩🇰","🇬🇦","🇺🇸","🇬🇧","🇹🇷","🇯🇴","🇧🇷","🏳️‍🌈","🇨🇷"]
    private var flag = [Int:String]()

    
    private func flag(for card: Card) -> String {
        if flag[card.identifier] == nil, flagChoices.count > 0 {
            
//              This code is called via extension of Int below
//            let x = 5.arc4random
//            let randomIndex = Int(arc4random_uniform(UInt32(flagChoices.count)))
            
            flag[card.identifier] = flagChoices.remove(at: flagChoices.count.arc4random)
        }
//Can also be written: return flag[card.identifier] ?? "?"
        if flag[card.identifier] != nil {
            return flag[card.identifier]!
        } else {
            return "?"
        }
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

