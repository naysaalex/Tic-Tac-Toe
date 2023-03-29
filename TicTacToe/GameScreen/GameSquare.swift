//
//  GameSquare.swift
//  TicTacToe
//
//  Created by admin on 2/22/23.
//

import SwiftUI

struct GameSquare{
    var id:Int //basically to track tiles 1-9
    var player:Player? //doesn't know which player it is(player 1 or player 2) so adding the "?" gives it the option of Player 1 or Player 2
    var image:Image{
        if let player = player{
            return player.gamePiece.image
        }
        else{
            return Image("none")
        }
    }
    static var reset:[GameSquare]{
        var squares=[GameSquare]()
        //MIDTERM EDIT - changed the range from 1-9 to 1-16 to accomodate for the extra tiles
            for index in 1...16{
                squares.append(GameSquare(id: index))
            }
            return squares
    }
    
}
