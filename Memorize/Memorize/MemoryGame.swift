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
//    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private var indexOfTheOneAndOnlyFaceUpCard: Card?
    private(set) var score: Int = 0

    // MARK: - Initilization
    init(numberOfPairsOfCards: Int, createCardContent: (Int) -> CardContent) {
        cards = [Card]()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }

    // MARK: - Functions
    mutating func choose(_ card: Card) {
        guard
            var chosenCard = cards.first(where: {$0.id == card.id}),
            !chosenCard.isFaceUp,
            !chosenCard.isMatched
        else {
            return
        }
        print("Chosen Card Initially \(chosenCard)")
        if var potentiallyMatchCard =  indexOfTheOneAndOnlyFaceUpCard {
            if chosenCard.content == potentiallyMatchCard.content {
                chosenCard.isMatched = true
                potentiallyMatchCard.isMatched = true
                score += 2
            } else {
                // If not matched and card is already seen then score should reduce by 1
                if chosenCard.isPreviouslySeen ||
                   potentiallyMatchCard.isPreviouslySeen {
                    score -= 1
                }
            }
            updateOriginalCard(chosenCard)
            updateOriginalCard(potentiallyMatchCard)
            indexOfTheOneAndOnlyFaceUpCard = nil
        } else {
            for index in cards.indices {
                if cards[index].isFaceUp {
                    cards[index].isFaceUp = false
                    cards[index].isPreviouslySeen = true
                }
            }
            indexOfTheOneAndOnlyFaceUpCard = chosenCard
        }
        chosenCard.isFaceUp.toggle()
        updateOriginalCard(chosenCard)
    }

    private mutating func updateOriginalCard(_ card: Card) {
//        This function will update the cards in the original set
        if let indexOfcardToUpdate = cards.firstIndex(where: {$0.id == card.id}) {
            cards[indexOfcardToUpdate].isFaceUp = card.isFaceUp
            cards[indexOfcardToUpdate].isMatched = card.isMatched
            cards[indexOfcardToUpdate].isPreviouslySeen = card.isPreviouslySeen
        }

    }
}
