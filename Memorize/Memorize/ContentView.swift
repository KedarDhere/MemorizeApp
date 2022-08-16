//
//  ContentView.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    //MARK - Initilization
    @ObservedObject var viewModel: EmojiMemoryGame
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            HStack{
                Text(viewModel.theme.name)
                Spacer()
                Text("Score: \(viewModel.score)")
            }.font(.largeTitle)
                .padding()
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(viewModel.cards, content: { card in
                        CardView(card: card)
                            .aspectRatio(2/3, contentMode: .fit)
                            .onTapGesture {
                                viewModel.choose(card: card)
                            }
                    })
                }
            }
            .foregroundColor(viewModel.theme.color)
            .padding()
            
            Button(action: {
                viewModel.newGame()
            }, label: {
                Text("New Game").font(.largeTitle)
            })
        }
    }
    
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack{
            if card.isFaceUp
            {
                shape.fill(.white)
                shape.stroke(lineWidth: 3)
                Text(card.content).font(.largeTitle)
            }
            else if card.isMatched
            {
                shape.opacity(0)
            }
            else
            {
                shape.fill()
            }
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        ContentView(viewModel: game)
            .preferredColorScheme(.dark)
        ContentView(viewModel: game)
            .preferredColorScheme(.light)
    }
}
