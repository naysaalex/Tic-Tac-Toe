//
//  GameService.swift
//  TicTacToe
//
//  Created by admin on 2/20/23.
//

import SwiftUI
@MainActor //will remember that it is a mainactor class
class GameService:ObservableObject{
    @Published var player1 = Player(gamePiece: .x, name: "Player 1")
    @Published var player2 = Player(gamePiece: .o, name: "Player 2")
    @Published var possibleMoves = Moves.all
    @Published var movesTaken = [Int]()
    @Published var gameOver = false
    @Published var gameBoard = GameSquare.reset
    @Published var isThinking = false //for the bot gameType
    
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
        gameOver || !gameStarted || isThinking
    }
    
    func setupGame(gameType: GameType, player1Name:String, player2Name:String)
    {
        switch gameType {
        case .single:
            self.gameType = .single
            player1.name = player1Name //- your name is Player1
            player2.name = player2Name
        case .peer:
            self.gameType = .peer
            /*player1Name = player1Name
            player2Name = player2Name*/
        case .bot:
            self.gameType = .bot
           /* player1Name = player1Name*/
            player2.name = UIDevice.current.name
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
        gameBoard = GameSquare.reset
    }
    
    func updateMoves(index: Int){
        if player1.isCurrent{
            player1.moves.append(index+1)
            gameBoard[index].player = player1
        }
        else
        {
            player2.moves.append(index+1)
            gameBoard[index].player = player2
        }
    }
    
    func checkIfWinner(){
        if player1.isWinner || player2.isWinner{
            gameOver = true
        }
    }
    
    func toggleCurrent(){
        player1.isCurrent.toggle()
        player2.isCurrent.toggle()
    }
    
    func makeMove(at index:Int){
        if gameBoard[index].player == nil{
            withAnimation{
                updateMoves(index: index)
            }
            checkIfWinner()
            if !gameOver{
                if let matchingIndex = possibleMoves.firstIndex(where: {$0==(index+1)}){
                    possibleMoves.remove(at: matchingIndex)
                }
                toggleCurrent()
                
                //bot logic
                if gameType == .bot && currentPlayer.name == player2.name
                {
                    Task{
                        await deviceMove()
                    }
                }
            }
            if possibleMoves.isEmpty
            {
                gameOver = true
            }
        }
    }
    
    func deviceMove() async
    {
        isThinking.toggle()
        try? await Task.sleep(nanoseconds: 100_000_000)
        
        if let move = possibleMoves.randomElement()
        {
            if let matchingIndex = Moves.all.firstIndex(where: {$0==move})
            {
                makeMove(at: matchingIndex)
            }
            isThinking.toggle()
        }
    }
}
