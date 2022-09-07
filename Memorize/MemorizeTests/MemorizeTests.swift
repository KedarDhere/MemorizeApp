//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by Kedar Dhere on 9/6/22.
//

import XCTest
@testable import Memorize

class MemoryGameTests: XCTestCase {

    func testInit() throws {
        // given
        let theme = Theme(
            name: "Games",
            emojis: ["⚽️"],
            numberOfPairOfCards: 1,
            color: .orange
        )

        // when
        let memoryGame = MemoryGame(
            numberOfPairsOfCards: 1,
            createCardContent: { pairIndex  in theme.emojis[pairIndex] }
        )

        // then
        XCTAssertEqual(memoryGame.cards.count, 2)
        XCTAssertEqual(memoryGame.score, 0)
    }

    func testChoose() throws {
        // given

        // when

        // then
    }

}
