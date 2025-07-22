//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Enrico Postolov on 16/10/24.
//

import SwiftUI

struct ContentView: View {
    // Start with a shuffled array
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    var body: some View {
        ZStack {
            // Apply a radial gradient with two colors starting at the same location
            // We define the colors with custom shades so that are prettier
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer() // We put spacer views to fit better the entire screen
                
                // Title
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundStyle(.white)
                
                // We define the entire outer VStack to take all the horizontal space needed
                // Then we also set a padding for its components, and a predefined background
                // Then we also specify a clipShape slightly rounded
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary) // Use secondary foreground style for some vibrancy
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        // When the button is tapped execute the action
                        Button {
                            flagTapped(number)
                        } label: {
                            // The label will be represented by an image
                            // Set a capsule shape to the image and give it a shadow to make it stand out
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .alert("Your score is...", isPresented: $showingScore) {
                            Button("Continue", action: askQuestion)
                        } message: {
                            Text("\(scoreTitle.uppercased())!")
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 30))
                
                Spacer()
                Spacer()
                
                // Score placeholder
                Text("Score: ???")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
    }
    
    // Function to manage the tap on the flag
    func flagTapped(_ number: Int) {
        // correctAnswer can be checked as it is global to the ContentView
        if number == correctAnswer {
            scoreTitle = "Correct"
        } else {
            scoreTitle = "Wrong"
        }
        
        showingScore = true
    }
    
    // Function to re-shuffle the array and set a new correct answer for a new game
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

struct TestsView: View {
    @State private var showingAlert = false
    
    var body: some View {
        VStack {
            // The stack is processed with the given order, so the first element will be at the top.
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
         .padding()
         
        // In this case, Swift can realize on its own to use a VStack, but if we prefer we can explicit the VStack
        VStack(alignment: .leading, spacing: 20) {
            Text("Hello world!")
            Text("This is another text view")
        }
        
        HStack(spacing: 20) {
            Text("Hello world!")
            Text("This is inside a stack")
        }
        
        VStack {
            Text("First")
            Text("Second")
            Text("Third")
            Spacer()
        }
        
        VStack {
            // 1 third of the space at the top, and 2 thirds at the bottom
            Spacer()
            Text("First")
            Text("Second")
            Text("Third")
            Spacer()
            Spacer()
        }
        
        ZStack(alignment: .top) {
            Text("Hello world!")
            Text("This is inside a ZStack")
        }
       
        // 3x3 grid test
        VStack {
            HStack {
                Text("1")
                Text("2")
                Text("3")
            }
            HStack {
                Text("4")
                Text("5")
                Text("6")
            }
            HStack {
                Text("7")
                Text("8")
                Text("9")
            }
        }
        
        ZStack {
            // This will permit the entire ZStack to be red, instead of the only text background -> we can also specify a frame
            // The .infinity value will allow to take all the free space if present
            Color.red
                // .frame(width: 200, height: 200)
                .frame(minWidth: 200, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
            Text("Your content")
        }
        .ignoresSafeArea()
        
        ZStack {
            VStack(spacing: 0) {
                Color.red
                Color.blue
            }
            
            Text("Your content")
                .foregroundStyle(.secondary)
                .padding(50)
                .background(.ultraThinMaterial)
        }
        .ignoresSafeArea()
        
        LinearGradient(colors: [.white, .black], startPoint: .top, endPoint: .bottom)
        
        LinearGradient(stops: [
            // The .init can be used instead of Gradient.stop, Swift will understand it on its own
            .init(color: .white, location: 0.45),
            .init(color: .black, location: 0.55)
        ], startPoint: .top, endPoint: .bottom)
        
        RadialGradient(colors: [.red, .blue], center: .center, startRadius: 20, endRadius: 200)
        
        AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
        
        ZStack {
            Text("Your content")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.white)
                .background(.red.gradient)
        }
        .ignoresSafeArea()
        
        VStack() {
            Button("Button 1") { }
                .buttonStyle(.bordered)
            Button("Button 2", role: .destructive) { }
                .buttonStyle(.bordered)
            Button("Button 3") { }
                .buttonStyle(.borderedProminent)
                .tint(.mint)
            Button("Button 4", role: .destructive) { }
                .buttonStyle(.borderedProminent)
        }
        
        // Completely custom button
        Button {
            print("Edit button was tapped")
        } label: {
          Text("Tap me!")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
        }
        
        // Button with only image
        Button {
            print("Edit button was tapped")
        } label: {
            Image(systemName: "pencil")
        }
        
        // Simple button with image and text
        Button("Edit", systemImage: "pencil") {
            print("Edit button was tapped!")
        }
        
        // Custom button with image + text
        Button {
            print("Edit button was tapped")
        } label: {
            Label("Edit", systemImage: "pencil")
                .padding()
                .foregroundStyle(.white)
                .background(.red)
        }
        
        // Simple button triggering an alert
        Button("Show Alert") {
            showingAlert = true
        }
        .alert("Important message", isPresented: $showingAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Please read this.")
        }
        
        // Apply a gradient color behind the VStacks
        LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            .ignoresSafeArea()
    }
}
