//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/10/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject{
    
    //MARK: - Initilization
    static var emojis: Array<String> = ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚", "🚛","🚜", "🛺", "✈️", "🚈", "🚂","🛳","🚀","🚡","🛵","🚍","🚔"]
    
    @Published private var model: MemoryGame<String> = MemoryGame ( numberOfPairsOfCards: 4 ,
                                                                    createCardContent: { pairIndex  in emojis[pairIndex] }
    )
    
    var cards: Array<MemoryGame<String>.Card> {
        model.cards
    }
    
    //MARK: - Intent
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }
}
