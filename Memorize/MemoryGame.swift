//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/10/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable {
    // MARK: - Properties
    
    struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var isPreviouslySeen: Bool = false
        var id: Int
    }
    private(set) var cards: [Card]
    private var indexOfTheOneAndOnlyFaceUpCard: Card?
    private(set) var score: Int = 0
    
    // MARK: - Initilization
    
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex*2 + 1))
        }
        cards.shuffle()
    }
    
    // MARK: - Functions
    
    /**
     This function is used to update the score and card details to statisy the following game conditions: 1. At a time only two cards should be faceUp.
     2. If the content of the card is matching then update the score by two.
     3. else facedown all the cards and if the if the any one of the card is already seen then reduce score by one.
    */
    mutating func choose(_ card: Card) {
        guard
            var chosenCard = cards.first(where: {$0.id == card.id}),
            !chosenCard.isFaceUp,
            !chosenCard.isMatched
        else { return }
        
        if var potentiallyMatchCard =  indexOfTheOneAndOnlyFaceUpCard {
            if chosenCard.content == potentiallyMatchCard.content {
                chosenCard.isMatched = true
                potentiallyMatchCard.isMatched = true
                score += 2  // If cards contain is matched then increase the score by 2
                updateDeck(with : chosenCard)
                updateDeck(with : potentiallyMatchCard)
            }
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            // If the cards are not matching then mark them as previouslySeen and face down all the cards
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].isFaceUp = false
                    cards[index].isPreviouslySeen = true
                }
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenCard
            if chosenCard.isPreviouslySeen {
                score -= 1
            }
        }
        chosenCard.isFaceUp.toggle()
        updateDeck(with: chosenCard)
    }
    
    ///This function will update the cards in the original set.
    private mutating func updateDeck(with card: Card) {
        guard let indexOfcardToUpdate = cards.firstIndex(where :{$0.id == card.id})
        else { return }
        cards[indexOfcardToUpdate].isFaceUp = card.isFaceUp
        cards[indexOfcardToUpdate].isMatched = card.isMatched
        cards[indexOfcardToUpdate].isPreviouslySeen = card.isPreviouslySeen
    }
    
}

