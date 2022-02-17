/**
 * MAPD724 - Assignment 3
 * File Name:    ContentView.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   February 14th, 2022
 */

import SwiftUI
import Firebase

@main
struct QuocPhongNgo_MAPD724_Assignment3App: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
