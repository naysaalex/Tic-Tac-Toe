//
//  StartView.swift
//  TicTacToe
//
//  Created by admin on 2/13/23.
//

import SwiftUI

struct StartView: View {
    //state properties: @State
    //can be accessed outside the structure
    @State private var gameType: GameType = .undetermined
    @State private var yourName = ""
    @State private var opponentName = ""
    @FocusState private var focus:Bool
    @State private var startGame = false //to tell you if the game started or not
    @EnvironmentObject var game: GameService
    
    var body: some View {
        
        VStack {
            Picker("Select Game", selection: $gameType) {
                Text("Select Game Type").tag(GameType.undetermined)
                Text("Two sharing device").tag(GameType.single)
                Text("Challenge your device").tag(GameType.bot)
                Text("Challenge a friend").tag(GameType.peer)
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 10, style: .continuous).stroke(style:StrokeStyle(lineWidth:2)).accentColor(.primary))
            
            Text(gameType.description)
                .padding()
            
            VStack{
                switch gameType{
                case .undetermined:
                    EmptyView()
                    //will be fixed later
                case .single:
                    TextField("Your Name", text: $yourName)
                    TextField("Opponent Name", text:$opponentName)
                case .bot:
                    TextField("Your Name", text: $yourName)
                case.peer:
                    EmptyView()
                    //will be fixed later
                }
            }
            .padding()
            .textFieldStyle(.roundedBorder)
            .focused($focus) //keyboard or not keyboard
            .frame(width: 350)
            
            if gameType != .peer
            {
                Button("Start Game"){
                    focus = false
                    startGame.toggle()
                }
                .buttonStyle(.borderedProminent)
                .disabled(
                    gameType == .undetermined ||
                    gameType == .bot && (yourName.isEmpty) ||
                    gameType == .single && (yourName.isEmpty || opponentName.isEmpty)
                )
                
                Image("LightModeWelcome")
            }
            Spacer()
        }
        .padding()
        .fullScreenCover(isPresented: $startGame){
            GameView()
        }
        .navigationTitle("Cross Over")
        .inNavigationStack()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(GameService())
    }
}
