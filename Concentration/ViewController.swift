//
//  ViewController.swift
//  Concentration
//
//  Created by Anti on 9/12/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    lazy var game = newGameHelper()
    
    // Custom Code Start
    
    @IBAction func newGame(_ sender: UIButton) {
        game = newGameHelper()
        //emojiChoices = ["🎃", "👻", "🦊", "🐨", "🐱", "🐭", "🐙", "🦑", "🍞"]
        //emojiChoices = emojiChooser()
        
    }
    
    func newGameHelper() -> Concentration {
        game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
        emojiChooser()
        return game
    }
    
    func emojiChooser() {
        var emojiArray = [String:[String]]()
        emojiArray["misc"] = ["🎃", "👻", "🦊", "🐨", "🐱", "🐭", "🐙", "🦑", "🍞"]
        emojiArray["activity"] = ["🏀", "🏈", "⚾️", "🎾", "🏐", "🏉", "🎱", "🏓", "🏸"]
        emojiArray["travelAndPlaces"] = ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚐"]
        emojiArray["objects"] = ["⌚️", "📱", "📲", "💻", "⌨️", "🖥", "🖨", "🖱", "🖲"]
        emojiArray["symbols"] = ["❤️", "🧡", "💛", "💚", "💙", "🖤", "💜", "💔", "❣️"]
        emojiArray["flags"] = ["🏳️", "🏴", "🏁", "🚩", "🏳️‍🌈", "🇦🇫", "🇦🇽", "🇦🇱", "🇩🇿"]
        
        let emojiArrayKeys = Array(emojiArray.keys)
        //print("emojiArrayKeys: \(emojiArrayKeys)")
        //print("length of emojiArraykeys: \(emojiArrayKeys.count)")
        
        let randomIndex = Int(arc4random_uniform(UInt32(emojiArrayKeys.count)))
        emojiChoices = emojiArray[emojiArrayKeys[randomIndex]]!
        //print("emojiChoices: \(emojiChoices)")
        //print("randomIndex: \(randomIndex)")
    }
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    // Custom Code End
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            game.chooseCard(at: cardNumber)
            
            // Update View
            updateViewFromModel()
        } else {
            print("chosen card was not in cardButtons")
        }
    }
    
    func updateViewFromModel() {
        flipCountLabel.text = "Flips: \(game.flipCount)"
        scoreLabel.text = "Score: \(game.score)"
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: UIControlState.normal)
                button.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
            } else {
                button.setTitle("", for: UIControlState.normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0) : #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1)
            }
        }
    }
    
    var emojiChoices = ["🎃", "👻", "🦊", "🐨", "🐱", "🐭", "🐙", "🦑", "🍞"]
    // emojiChooser()
    
    var emoji = [Int:String]()
    
    func metaEmoji(for card: Card) -> String {
        emojiChooser()
        return emoji(for: card)
    }
    
    func emoji(for card: Card) -> String {
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
            emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            //print("emoji: \(emoji[card.identifier] ?? "?")")
        }
        return emoji[card.identifier] ?? "?"
    }
}

