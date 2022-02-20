/**
 * MAPD724 - Assignment 3
 * File Name:    HelpView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   February 19th, 2022
 */

import SwiftUI
import CoreData

struct HelpView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(red: 197/255,
                    green: 231/255, blue: 255/255))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("Slot Machine")
                        .bold()
                        .foregroundColor(Color(red: 137/255, green: 80/255, blue: 23/255))
                }.scaleEffect(3)
                    .padding(.all, 50)
                
                HStack {
                    Text(". Jackpot is 5000$ at the first time. In these next time, this amount is 1000$")
                }.scaleEffect(1.2)
                    .padding([.leading, .trailing, .bottom], 30)
                
                HStack {
                    Text(". Jackpot amount will be added credits when the user loses a bet.")
                }.scaleEffect(1.2)
                    .padding([.leading, .trailing, .bottom], 30)
                
                HStack {
                    Text(". When you get two same types of fruits, you will win your bet. Otherwise, one blank fruit means you lose your bet (x2 or x3 in case of two or three blank fruits).")
                }.scaleEffect(1.2)
                    .padding([.leading, .trailing], 40)
                    .padding(.bottom, 30)
                
                HStack {
                    Text(". When you get three same types of fruits, you will win JACKPOT.")
                }.scaleEffect(1.2)
                    .padding([.leading, .trailing, .bottom], 30)
                
                HStack {
                    Text("THANK YOU!")
                }.scaleEffect(2)
                .padding([.leading, .trailing, .bottom], 30)
                .foregroundColor(Color(red: 164/255,
                    green: 60/255, blue: 36/255))
                Spacer()
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
