//
//  TicTacToeApp.swift
//  TicTacToe
//
//  Created by admin on 2/13/23.
//

import SwiftUI

@main
struct AppEntry: App {
//difference between a struct and class is that two instances of a class are duplicates
//struct is value type and class is reference type
    @StateObject var game = GameService()
    var body: some Scene {
        WindowGroup {
            StartView()
                .environmentObject(game)
        }
    }
}
