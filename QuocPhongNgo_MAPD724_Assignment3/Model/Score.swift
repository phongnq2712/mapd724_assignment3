/**
 * MAPD724 - Assignment 3
 * File Name:    Score.swift
 * Author:         Quoc Phong Ngo
 * Student ID:   301148406
 * Version:        1.0
 * Date Modified:   February 17th, 2022
 */

import SwiftUI

struct Score: Codable, Identifiable {
    var id: String = UUID().uuidString
    var score: Int?
}
