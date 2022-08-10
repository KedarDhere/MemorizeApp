//
//  ContentView.swift
//  Memorize
//
//  Created by Kedar Dhere on 8/9/22.
//

import SwiftUI

struct ContentView: View {
    
    static let vehicles =  ["🚗","🚕","🚙","🚌","🚎","🏎","🚓","🚑","🚒","🚐","🛻","🚚", "🚛","🚜", "🛺", "✈️", "🚈", "🚂","🛳","🚀","🚡","🛵","🚍","🚔"]
    let flags = [ "🏳️", "🏳️‍🌈", "🇦🇲", "🇦🇷", "🇧🇾", "🇰🇾","🇨🇻","🇧🇼"]
    let faces = ["😀","☺️","😅","😂","😎","🥹","😚","🤩","😱","😌"]
    
    @State var emojis: Array<String> = vehicles
    @State var emojiCount = 8
    
    var body: some View {
        VStack {
            Text("Memorize").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]){
                    ForEach(emojis[0..<emojiCount], id: \.self, content: { emoji in
                        CardView(content: emoji).aspectRatio(2/3, contentMode: .fit)
                    })
                }
            }
            .foregroundColor(.red)
            
            Spacer()
            
            HStack {
                vehicle
                Spacer()
                flag
                Spacer()
                face
            }.font(.title2)
             .padding(.horizontal)
            
        }.padding()
    }
    
    var vehicle: some View {
        Button(action: {
            emojis =  ContentView.vehicles.shuffled()

        }, label: {
            VStack {
                Text("Vehicles")
                Image(systemName: "car.circle").font(.custom("Test", size: 50))
            }
        })
    }
    
    var flag: some View {
        Button(action: {
            emojis = flags.shuffled()
        }, label: {
            VStack{
                Text("Flags")
                Image(systemName: "flag.circle").font(.custom("Test", size: 50))
            }
        })
    }
    
    var face: some View {
        Button(action: {
            emojis = faces.shuffled()
        }, label: {
            VStack{
                Text("Faces")
                Image(systemName: "face.smiling").font(.custom("Test", size: 50))
            }
            
        })
    }
    
}

struct CardView: View {
    @State var isFaceUp: Bool = true
    var content: String
    var body: some View {
        let shape = RoundedRectangle(cornerRadius: 20)
        ZStack{
            if isFaceUp {
                shape.fill(.white)
                shape.stroke(lineWidth: 3)
                Text(content).font(.largeTitle)
            }
            else {
                shape.fill()
            }
        }.onTapGesture(perform: {
            isFaceUp = !isFaceUp
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
