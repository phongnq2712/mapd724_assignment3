/**
 * MAPD724 - Assignment 3
 * File Name:    ScoreViewModel.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   February 19th, 2022
 */

import Foundation
import FirebaseFirestore

class ScoreViewModel: ObservableObject {
    
    @Published var scores = [Score]()
    private var db = Firestore.firestore()
        
    init() {
        self.fetchData()
    }
    
    /**
     * Add new score to Firebase Firestore
     */
    func addData(score: Int) {
        var ref: DocumentReference? = nil
        ref = db.collection("scores").addDocument(data: [
            "score": score
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
    }
    
    /**
     * Read data from Firebase Firestore
     */
    func fetchData() {
        db.collection("scores").addSnapshotListener { [self] (querySnapshot, error) in
            guard let documents = querySnapshot?.documents else {
                print("No documents")
                return
            }
            
            self.scores = documents.map { (queryDocumentSnapshot) -> Score in
                let data = queryDocumentSnapshot.data()
                let scoreFromDB = data["score"] as? Int ?? 0
                
                return Score(score: scoreFromDB)
            }
        }
    }
    
    /**
     * Find the highest score in database
     */
    func getTheHighestScore() -> Int {
        var maxScore = 0
                
        for score in self.scores {
            if(score.score! > maxScore) {
                maxScore = score.score!
            }
        }
        
        return maxScore
    }
}
