//
//  ContentView.swift
//  ColorBlind
//
//  Created by Alpsu Dilbilir on 10.02.2022.
//

import SwiftUI

struct ColorBlindView: View {
    
    let columns = [GridItem(.flexible()),
                   GridItem(.flexible()),
                   GridItem(.flexible())]
    let colors = [Color.red, Color.gray, Color.blue, Color.secondary, Color.brown, Color.green, Color.yellow, Color.cyan, Color.primary, Color.pink, Color.orange, Color.purple]
    
    @State private var randomNum = Int.random(in: 0..<9)
    @State private var randomColor = Int.random(in: 0..<11)
    @State private var score = 0
    @State private var opacity = 0.6
    @State private var life = 3
    @State private var isGameOver = false

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack(alignment: .center, spacing: 5) {
                        Text("Score: \(score)")
                            .font(.system(size: 30))
                        Spacer()
                        Text("Life: \(life)")
                            .font(.system(size: 30))
                    }
                    .padding()
                    Spacer()
                    LazyVGrid(columns: columns) {
                        ForEach(0..<9) { circle in
                            ZStack {
                                Circle()
                                    .frame(width: 100, height: 100, alignment: .center)
                                    .foregroundColor( circle == randomNum ?  colors[randomColor].opacity(opacity) : colors[randomColor])
                            }
                            .onTapGesture {
                                isCorrectCircle(randomNum: randomNum, circle: circle)
                                isGameOver(life: life, isGameOver: isGameOver)
                                makeGameHarder(score: score)
                                updateCircles()
                                resetGame()
                            }
                        }
                    }
                    Spacer()
                }
            }
        }
        .alert("Game Over", isPresented: $isGameOver) {
            Button("OK") {
                self.isGameOver = false
            }
        } message: {
            Text("Try Again")
        }
    }
    func isGameOver(life: Int, isGameOver: Bool) {
        if life < 1 {
            self.isGameOver = true
        }
    }
    func isCorrectCircle(randomNum: Int, circle: Int) {
        if randomNum == circle {
            score += 1
        } else {
            life -= 1
        }
    }
    
    func updateCircles() {
        randomNum = Int.random(in: 0..<9)
        randomColor = Int.random(in: 0..<12)
    }
    func resetGame() {
        if self.isGameOver {
            self.opacity = 0.6
            self.score = 0
            self.life = 3
        }
    }
    func makeGameHarder(score: Int) {
        if score == 5 {
            opacity += 0.1
        }
        if score == 10 {
            opacity += 0.1
        }
        if score == 15 {
            opacity += 0.1
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ColorBlindView()
    }
}
