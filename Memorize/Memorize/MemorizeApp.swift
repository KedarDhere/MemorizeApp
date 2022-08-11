//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/9/22.
//

import SwiftUI

@main
struct MemorizeApp: App {
    var body: some Scene {
        let game = EmojiMemoryGame()
        WindowGroup {
            ContentView(viewModel: game)
        }
    }
}
