//
//  Concentration.swift
//  Concentration
//
//  Created by Anti on 9/13/18.
//  Copyright © 2018 Anti. All rights reserved.
//

import Foundation

class Concentration
{
    var cards = [Card]()
    
    var flipCount = 0
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    var score = 0
    var failedIndexes = [Int]()
    
    func chooseCard(at index: Int) {
        flipCount += 1
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                // check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    // Score Code
                    score += 2
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = nil
                
                } else {
                // either no cards or 2 cards are face up
                // nil, card/ card, card
                //print("Card \(cards[index].identifier) is false")
                //print("Card \(indexOfOneAndOnlyFaceUpCard ?? -1) is also false")
                
                var scoreChecker = false
                
                for flipDownIndex in cards.indices {
                    // Score Code Start
                    if cards[flipDownIndex].isFaceUp == true, cards[flipDownIndex].isMatched == false {
                        if failedIndexes.count > 2 {
                            for temp in failedIndexes {
                                if flipDownIndex == temp {
                                    scoreChecker = true
                                }
                            }
                        }
                        if scoreChecker == true {
                            score -= 1
                            scoreChecker = false                        }
                        failedIndexes.append(flipDownIndex)
                        //print("Card #\(flipDownIndex) is false")
                    }
                    // Score Code End
                    
                    cards[flipDownIndex].isFaceUp = false
                }
                cards[index].isFaceUp = true
                indexOfOneAndOnlyFaceUpCard = index
                
            }
        }
    }

    init(numberOfPairsOfCards: Int) {
        for _ in 0..<numberOfPairsOfCards {
            let card = Card()
            
            cards += [card, card]
            // cards.append(card)
            // cards.append(card)
        }
        // TODO: Shuffle the cards
        
        func shuffleCard() {
            var shuffledDeck = [Card]()
            for _ in 0..<cards.count {
                let randomInt = Int(arc4random_uniform(UInt32(cards.count)))
                shuffledDeck.append(cards.remove(at: randomInt))
            }
            cards = shuffledDeck
        }
        
        shuffleCard()
    }
}
