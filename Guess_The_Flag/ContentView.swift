//
//  ContentView.swift
//  Guess_The_Flag
//
//  Created by Thomas George on 09/05/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var flags: [String] = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var flagsSelection: Int = Int.random(in: 0...2)
    @State private var result: String = ""
    @State private var showingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var score: Int = 0
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .black]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            VStack(spacing: 30) {
                VStack(spacing: 8) {
                    Text("Tap the flag of:")
                    Text("\(flags[flagsSelection])")
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                }
                
                ForEach(0..<3){ number in
                    Button(action: {
                        flagTapped(number)
                    }) {
                        Image(flags[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                    }
                }
                
                VStack {
                    Text("Your score: \(score)")
                        .foregroundColor(Color.white)
                }
            }
        }
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(result), message: Text(alertMessage), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        }
    }
    
    func flagTapped(_ number: Int) {
        if flagsSelection == number {
            result = "Correct"
            alertMessage = "10 points"
            score += 10
        } else {
            result = "Failed"
            alertMessage = "Retry"
            score = 0
        }
        showingAlert = true
    }
    
    func askQuestion() {
        flags.shuffle()
        flagsSelection = Int.random(in: 0...2)
        showingAlert = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
