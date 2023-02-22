//
//  GameService.swift
//  TicTacToe
//
//  Created by admin on 2/20/23.
//

import Foundation
@MainActor //will remember that it is a mainactor class
class GameService:ObservableObject{
    @Published var player1 = Player(gamePiece: .x, name: "Player 1")
    @Published var player2 = Player(gamePiece: .o, name: "Player 2")
    @Published var possibleMoves = Moves.all
    @Published var movesTaken = [Int]()
    @Published var gameOver = false
    
    var gameType = GameType.single //fix this later
    
    var currentPlayer:Player{
        if player1.isCurrent
        {
            return player1
        }
        else
        {
            return player2
        }
    }
    
    var gameStarted:Bool{
        //keep your logic to variables rather than with buttons
        player1.isCurrent || player2.isCurrent
        //don't have to specify return as it would default since you've assigned it as Bool
    }
    
    var boardDisabled:Bool{
        gameOver || !gameStarted
    }
    
    func setupGame(gameType: GameType, player1Name:String, player2Name:String)
    {
        switch gameType {
        case .single:
            self.gameType = .single
           // player1.name = player1Name - your name is Player1
            player2.name = player2Name
        case .peer:
            self.gameType = .peer
            /*player1Name = player1Name
            player2Name = player2Name*/
        case .bot:
            self.gameType = .bot
           /* player1Name = player1Name
            player2Name = player2Name*/
        case .undetermined:
            break
        }
    }
    
    func reset(){
        player1.isCurrent = false
        player2.isCurrent = false
        player1.moves.removeAll()
        player2.moves.removeAll()
        gameOver = false
        possibleMoves = Moves.all
    }
}
