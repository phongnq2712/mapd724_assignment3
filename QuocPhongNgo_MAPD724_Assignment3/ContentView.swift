/**
 * MAPD724 - Assignment 3
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   February 19th, 2022
 */

import SwiftUI
import CoreData

struct ContentView: View {
        
    @Environment(\.managedObjectContext) private var viewContext

    private var symbols = ["apple", "cherry", "lemon", "orange", "strawberry", ""]
    @State private var numbers = [0, 1, 2]
    @State private var playerMoney = 1000
    @State private var winnings = 0;
    @State private var apple = 0;
    @State private var cherry = 0;
    @State private var lemon = 0;
    @State private var orange = 0;
    @State private var strawberry = 0;
    @State private var playerBet: String = ""
    @State private var isDisabledSpinButton = false
    @State private var confirmExit = false
    @State private var showingAlert = false
    @State private var message: String = ""
    @State private var jackPot = 5000
    @ObservedObject private var scoreVM = ScoreViewModel()
    var body: some View {
        NavigationView {
            ZStack {
                Rectangle()
                .foregroundColor(Color(red: 197/255,
                    green: 231/255, blue: 255/255))
                .edgesIgnoringSafeArea(.all)
            
                VStack {
//                    HStack {
//                        Text("Slot Machine")
//                        .bold()
//                        .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
//                    }.scaleEffect(2)
                    
                    HStack {
                        Text("The highest score: " + String(self.scoreVM.getTheHighestScore()))
                        .bold()

                    }
                                    
                    HStack {
                        // logo
                        Image("slot-machine").resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    }.padding(.bottom, 10)
                    // Jackpot money
                    Text("Jackpot: " + String(jackPot))
                    .bold()
                    .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    // Credits
                    Text("Player Money: " + String(playerMoney))
                    .foregroundColor(.black)
                    .padding(.all, 10)
                    .background(Color.white.opacity(0.8))
                    .cornerRadius(20)
                    HStack {
                        Text("Bet Amount: ")
                        .foregroundColor(.black)
                        .padding(.all, 10)
                        .background(Color.white.opacity(0.8))
                        .cornerRadius(20)
                        let binding = Binding<String>(get: {
                                self.playerBet
                            }, set: {
                                self.playerBet = $0
                                // enable Spin button
                                if(self.isDisabledSpinButton) {
                                    self.isDisabledSpinButton = false
                                }
                            })
                        TextField("Enter Bet", text: binding)
                        .foregroundColor(.red)
                        .padding(.all, 10)
                        .frame(width: 100, height: 35, alignment: .trailing)
                    }
                
                    // Cards
                    HStack {
                        Spacer()
                        Image(symbols[numbers[0]]).resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    
                        Image(symbols[numbers[1]]).resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                    
                        Image(symbols[numbers[2]]).resizable()
                        .frame(width: 95.0, height: 95.0)
                        .aspectRatio(1, contentMode: .fit)
                        .background(Color.black.opacity(0.8))
                        .cornerRadius(20)
                        .padding(.all, 10)
                        Spacer()
                    }
               
                    // Message
                    HStack {
                        TextField("", text: $message)
//                        .bold()
                        .foregroundColor(Color(red: 255/255, green: 45/255, blue: 147/255))
                        .padding(10)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 24, weight: .heavy, design: .default))
                        .background(Color(red: 0/255, green: 29/255, blue: 38/255))
                        
                    }
                // Spin Button
                    HStack {
                        Button(action: spinPressedButton) {
                        Text("Spin")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 20)
                            .background(self.isDisabledSpinButton == true ? Color.gray : Color.blue)
                            .cornerRadius(20)
                    }.padding(.bottom, 10).disabled(self.isDisabledSpinButton)
                    }
                                
                    HStack {
                    // Reset Button
                        Button(action: resetButton) {
                        Text("Reset")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 15)
                            .background(.orange)
                            .cornerRadius(20)
                        }.padding(.bottom, 20)
                        // Quit Button
                        Button(action: saveScoreButton) {
                        Text("Save Score")
                            .bold()
                            .foregroundColor(.white)
                            .padding(.all, 15)
                            .background(.orange)
                            .cornerRadius(20)
                    }.padding(.bottom, 20)
                    .alert("Save score successfully!", isPresented: $showingAlert) {
                                Button("OK", role: .cancel) { }
                            }
                    
                        Button(action: quitButton) {
                            Text("Quit")
                                .bold()
                                .foregroundColor(.white)
                                .padding(.all, 15)
                                .background(.orange)
                                .cornerRadius(20)
                            }.padding(.bottom, 20)
                        .confirmationDialog(
                            "Are you sure you want to quit this game?",
                                isPresented: $confirmExit)
                                {
                                    Button {
                                        // Handle import action.
                                        exit(0)
                                    } label: {
                                        Text("OK")
                                    }
                                    Button("Cancel", role: .cancel) {
                                    }
                                }
                    }
                    NavigationLink(destination:HelpView(), label: {
                            Text("Help")
                            .bold()
                            .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                    })
                }
            }
        }
    }
    
    /**
     * Save score button event
     */
    private func saveScoreButton() {
        self.scoreVM.addData(score: self.playerMoney)
        showingAlert = true
    }
    
    /**
    * Pressing Quit button event
     */
    private func quitButton() {
        confirmExit = true
    }
    
    /**
    * Pressing Reset button event
     */
    private func resetButton() {
        self.jackPot = 5000
        self.playerMoney = 1000
        self.message = ""
    }
    
    /**
     * Pressing Spin button event
     */
    private func spinPressedButton() {
        self.apple = 0
        self.lemon = 0
        self.cherry = 0
        self.strawberry = 0
        self.orange = 0
        self.message = ""
        // Check whether the user has enough money or not
        let currentBet = (playerBet as NSString).integerValue
        // current Bet = 0
        if(currentBet == 0) {
            self.message = "Please enter bet amount!"
            
            return
        }
        // current Bet > player money
        if(currentBet > self.playerMoney) {
            // grey out the Spin button
            self.isDisabledSpinButton = true
            self.message = "Invalid bet amount!"
            
            return
        } else {
            self.isDisabledSpinButton = false
        }
        self.numbers[0] = Int.random(in: 0...self.symbols.count - 1)
        self.numbers[1] = Int.random(in: 0...self.symbols.count - 1)
        self.numbers[2] = Int.random(in: 0...self.symbols.count - 1)
        
        // loop array numbers
        for (index, element) in self.numbers.enumerated() {
            switch(element) {
            case 0:
                // apple
                self.apple += 1
                break
            case 1:
                // cherry
                self.cherry += 1
                break
            case 2:
                // lemon
                self.lemon += 1
                break
            case 3:
                // orange
                self.orange += 1
                break
            case 4:
                self.strawberry += 1
                break
            case 5:
                // Lost
                self.playerMoney -= currentBet
                self.jackPot += currentBet
                self.message = "You lost!"
                break
            default:
                break
            }
        }
        // Player will win if having two same fruits
        if(self.apple == 2 || self.orange == 2 || self.strawberry == 2 || self.cherry == 2
           || self.lemon == 2) {
            self.playerMoney += currentBet * 2
            self.message = "You win!"
        }
        // Player will win Jackpot if having three same fruits
        if(self.apple == 3 || self.orange == 3 || self.strawberry == 3 || self.cherry == 3
           || self.lemon == 3) {
            self.message = "JACKPOT"
            self.playerMoney += self.jackPot
            self.jackPot = 1000
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
