/**
 * MAPD724 - Assignment 3
 * File Name:    HelpView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   February 14th, 2022
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
                }.scaleEffect(2)
            }
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
