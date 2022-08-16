//
//  MemoryGame.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/10/22.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Equatable{
    
    
    //MARK - Properties
    struct Card: Identifiable {
        
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var isPreviouslySeen:Bool = false
        var id: Int
        
    }
    
    private(set) var cards: Array<Card>
    private var indexOfTheOneAndOnlyFaceUpCard: Int?
    private(set) var score: Int = 0
    
    //MARK - Initilization
    init(numberOfPairsOfCards: Int, createCardContent: (Int) ->CardContent) {
        cards = Array<Card>()
        for pairIndex in 0..<numberOfPairsOfCards {
            let content: CardContent = createCardContent(pairIndex)
            cards.append(Card(content: content, id: pairIndex*2))
            cards.append(Card(content: content, id: pairIndex * 2 + 1))
        }
        cards.shuffle()
    }
    
    //MARK: - Functions
    mutating func choose(_ card  : Card) {
        if let chosenIndex = cards.firstIndex(where: {$0.id == card.id}),
           !cards[chosenIndex].isFaceUp,
           !cards[chosenIndex].isMatched
        {
            if let potentiallyMatchIndex =  indexOfTheOneAndOnlyFaceUpCard
            {
                if cards[chosenIndex].content == cards[potentiallyMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentiallyMatchIndex].isMatched = true
                    score += 2
                }else
                {
                    //If not matched and card is already seen then score should reduce by 1
                    if cards[chosenIndex].isPreviouslySeen ||
                        cards[potentiallyMatchIndex].isPreviouslySeen
                    {
                        score -= 1
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = nil
            }
            else
            {
                for index in cards.indices {
                    if cards[index].isFaceUp{
                        cards[index].isFaceUp = false
                        cards[index].isPreviouslySeen = true
                    }
                }
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
            cards[chosenIndex].isFaceUp.toggle()
        }
    }
}
