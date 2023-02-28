//
//  SquareView.swift
//  TicTacToe
//
//  Created by admin on 2/28/23.
//

import SwiftUI

struct SquareView: View {
    //to access the GameService class in this view
    @EnvironmentObject var game:GameService
    let index:Int
    var body: some View {
        Button{
            if !game.isThinking{
                game.makeMove(at: index)
            }
        }label:{
            game.gameBoard[index].image
                .resizable()
                .frame(width:100, height: 100)
                .border(.primary)
        }
        .disabled(game.gameBoard[index].player != nil)//nil is null
    }
}

struct SquareView_Previews: PreviewProvider {
    static var previews: some View {
        SquareView(index: 1)
            .environmentObject(GameService())//basically instantiating the class
    }
}
