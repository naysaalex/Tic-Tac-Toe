//
//  GameView.swift
//  TicTacToe
//
//  Created by admin on 2/15/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var game: GameService
    @Environment(\.dismiss) var dismiss //"\." is the root
   
    var body: some View {
        VStack{
            if [game.player1.isCurrent, game.player2.isCurrent].allSatisfy{ $0 == false } //used to see if certain functionality is satisfied
            {
                Text("Select a player to start")
            }
            
            HStack{
                Button(/*label or name inside this*/game.player1.name){
                    //action inside the button
                    game.player1.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player1.isCurrent))
                Button(game.player2.name){
                    game.player2.isCurrent = true
                }
                .buttonStyle(PlayerButtonStyle(isCurrent: game.player2.isCurrent))
                
                
            }
        }.toolbar{
            ToolbarItem(placement: .navigationBarTrailing)
            {
                //content or code
                Button("End Game"){
                    dismiss()
                }
                .buttonStyle(.bordered)
            }
        }
        .navigationTitle("Cross Over")
        .inNavigationStack()
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(GameService())
    }
}

struct PlayerButtonStyle:ButtonStyle{
    let isCurrent:Bool
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(8)
            .background( RoundedRectangle(cornerRadius: 8).fill(isCurrent ? Color.green:Color.gray))//question mark signifies that if it is true then it will set it to green
        //doesn't have access to the game.player1 so can just write isCurrent --> will be passed in
        .foregroundColor(.white)
        
    }
}
