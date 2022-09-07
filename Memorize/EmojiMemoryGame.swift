//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/10/22.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {

    // MARK: - Properties

    @Published private var model: MemoryGame<String>

    private static let defaultTheme = Theme(
            name: "Vehicles",
            emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒",
                     "🚐", "🛻", "🚚", "🚛", "🚜", "🛺", "✈️", "🚈", "🚂",
                     "🛳", "🚀", "🚡", "🛵", "🚍", "🚔"],
            numberOfPairOfCards: 10,
            color: .red
        )

    private(set) var theme: Theme
    private static let themes: [Theme] = [
        Theme(
            name: "Vehicles",
            emojis: ["🚗", "🚕", "🚙", "🚌", "🚎", "🏎", "🚓", "🚑", "🚒",
                     "🚐", "🛻", "🚚", "🚛", "🚜", "🛺", "✈️", "🚈", "🚂",
                     "🛳", "🚀", "🚡", "🛵", "🚍", "🚔"],
            numberOfPairOfCards: 10,
            color: .red
        ),

        Theme(
            name: "Flags",
            emojis: ["🏳️", "🇦🇹", "🇦🇺", "🇧🇿", "🇧🇦", "🇦🇲", "🇨🇦", "🇰🇾", "🇧🇧", "🇮🇴"],
            numberOfPairOfCards: 9,
            color: .blue
        ),

        Theme(
            name: "Faces",
            emojis: ["😀", "🤣", "🙃", "😚", "😎", "🤩"],
            numberOfPairOfCards: 6,
            color: .yellow
        ),

        Theme(
            name: "Places",
            emojis: ["🏡", "🏔", "🕍", "🏣", "🏛"],
            numberOfPairOfCards: 5,
            color: .purple
        ),

        Theme(
            name: "Food",
            emojis: ["🍇", "🍔", "🍟", "🥪", "🍫", "🍧", "🍚", "🎂"],
            numberOfPairOfCards: 8,
            color: .green
        ),

        Theme(
            name: "Games",
            emojis: ["⚽️", "🏑", "🏏", "🥍"],
            numberOfPairOfCards: 4,
            color: .orange
        )
    ]

    var cards: [MemoryGame<String>.Card] {
        model.cards
    }

    var score: Int {
        model.score
    }

    // MARK: - Initilization

    init() {
        // Select the random theme and its data
        theme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.defaultTheme

        // Cards should be shuffled always
        theme.emojis.shuffle()

        model = EmojiMemoryGame.createMemoryGame(theme: theme)

        // Initially all cards must be face down after clicking on the NewGame button
        allCardsFaceDown()
    }

    // MARK: - Functions

    static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        MemoryGame(
            numberOfPairsOfCards: theme.numberOfPairOfCards,
            createCardContent: { pairIndex  in theme.emojis[pairIndex] }
        )
    }

    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }

    func newGame() {
        // Select the random theme and its data
        theme = EmojiMemoryGame.themes.randomElement() ?? EmojiMemoryGame.defaultTheme

        // Cards should be shuffled always
        theme.emojis.shuffle()

        model = EmojiMemoryGame.createMemoryGame(theme: theme)

        // Initially all cards must be face down after clicking on the NewGame button
        allCardsFaceDown()
    }

    func allCardsFaceDown() {
        for var card in cards {
            card.isFaceUp = false
        }
    }
}
