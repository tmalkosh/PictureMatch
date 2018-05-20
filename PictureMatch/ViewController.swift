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
    
    private var game : PictureMatch!
    
    var numberOfPairsOfCards: Int {
        return flagChoices.count
    }
    
    
    private(set) var flipCount = 0 {
        didSet {
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    @IBOutlet weak var collectionView:
    UICollectionView!
    
    //TODO delete cardButtons
    @IBOutlet private var cardButtons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        game = PictureMatch(numberOfPairsOfCards: numberOfPairsOfCards)
        game.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
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
            fatalError("WHAAAAAT!")
        }
    }
    
    
    func resetGame() {
        game.resetCard()
    }
    
    @IBAction func resetButtonWasTapped(_ sender: UIButton) {
        resetGame()
    }
}
extension ViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        flipCount += 1
        game.chooseCard(at: indexPath.item)
        collectionView.reloadData()
    }
}
extension ViewController:
UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return game.cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionViewCell", for: indexPath) as! CardCollectionViewCell
            let card = game.cards[indexPath.item]
            if card.isFaceUp {
                cell.titleLabel.text = flag(for: card)
                cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                cell.isUserInteractionEnabled = false
            } else {
                cell.titleLabel.text = ""
                cell.backgroundColor = card.isMatched ?  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) : #colorLiteral(red: 0.521568656, green: 0.1098039225, blue: 0.05098039284, alpha: 1)
                cell.isUserInteractionEnabled = true
                if cell.backgroundColor ==  #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1) {
                    cell.isUserInteractionEnabled = false
                }
            }
        return cell
    }
}

extension ViewController: PictureMatchDelegate {
    func gameWasWon() {
        let alert = UIAlertController(title: "You Won!", message: "Flip Count:\(flipCount)", preferredStyle:.alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) {
            [weak self]
            _ in
            self?.resetGame()
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    func wasReset() {
        flipCount = 0
        collectionView.reloadData()
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



//TODO Score Algorithm flipCount/ 22

