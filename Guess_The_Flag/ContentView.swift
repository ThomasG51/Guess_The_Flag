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
    @State private var isCorrect: Bool = false
    @State private var isBlured: Bool = false
    @State private var selectedFlag: Int = 0
    
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
                        withAnimation {
                            flagTapped(number)
                        }
                    }) {
                        Image(flags[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.white, lineWidth: 1))
                            .opacity(self.isCorrect && self.selectedFlag != number ? 0.25 : 1)
                            .scaleEffect(self.isCorrect && self.selectedFlag != number ? 0.75 : 1)
                    }
                    .rotation3DEffect(.degrees(self.isCorrect && self.selectedFlag == number ? 360 : 0), axis: (x:0, y:1, z:0))
                    
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
        self.selectedFlag = number
        
        if flagsSelection == number {
            self.isCorrect = true
            self.result = "Correct"
            self.alertMessage = "10 points"
            self.score += 10
        } else {
            self.result = "Failed"
            self.alertMessage = "Retry"
            self.score = 0
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.showingAlert = true
        }
    }
    
    func askQuestion() {
        self.isCorrect = false
        self.flags.shuffle()
        self.flagsSelection = Int.random(in: 0...2)
        self.showingAlert = false
    }
    
    func animateFlags(flag: Int) {
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
