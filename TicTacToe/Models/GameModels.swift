//
//  GameModels.swift
//  TicTacToe
//
//  Created by admin on 2/13/23.
//

import Foundation
import SwiftUI
//enumerated data type gives a bunch of variables and gives a number in sequence
enum GameType {
case single, bot, peer, undetermined
    
    var description: String {
        switch self {
        case .single: //.single since it is referring to a class or structure
            return "Share your device and play against a friend"
        case .bot:
            return "play with your device"
        case .peer:
            return "Invite someone near you with the app to play"
        case .undetermined:
            return ""
        }
    }
}

enum GamePiece:String{
    case x,o
    var image:Image{
        Image(self.rawValue)
    }
}

struct Player{
    let gamePiece:GamePiece
    var name:String
    var moves:[Int] = []
    var isCurrent = false //initialized it so didn't need to specify with :Bool
    var isWinner:Bool {
        for moves in Moves.winningMoves{
            if moves.allSatisfy(self.moves.contains){
                return true
            }
        }
        return false
    }
}

enum Moves{
    //MIDTERM EDIT - added #s 10-16 to the array
    static var all:[Int] = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16] //static implies that it can not be changed by anyone
    //MIDTERM EDIT - altered the arrays and added additional arrays to match the corresponding 4x4 potential wins
    static var winningMoves = [
    [1,2,3,4],
    [5,6,7,8],
    [9,10,11,12],
    [13,14,15,16],
    [1,6,11,16],
    [4,7,10,13],
    [1,5,9,13],
    [2,6,10,14],
    [3,7,11,15],
    [4,8,12,16]]
}
