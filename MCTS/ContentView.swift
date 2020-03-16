//
//  ContentView.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import SwiftUI

struct ProgressBar: View {
    
    @State var isShowing = false
    @Binding var progress: CGFloat
    
    var body: some View {
        ZStack(alignment: .leading) {
            Rectangle()
                .foregroundColor(Color.gray)
                .opacity(0.3)
                .frame(width: 345.0, height: 8.0)
            Rectangle()
                .foregroundColor(Color.blue)
                .frame(width: self.isShowing ? 345.0 * (self.progress / 100.0) : 0.0, height: 8.0)
                .animation(.linear(duration: 0.6))
        }
        .onAppear {
            self.isShowing = true
        }
        .cornerRadius(4.0)
    }
}


struct ContentView: View {
    @State var output : String = ""
    
    @State var selectedGameCount: String = "10"
    @State var gameSize: String = "10"
    @State var ledgeBoard: String = "0 2 0 1 0 1 1 0 0 1"
    @State var K: String = "3"
    @State var verbose: Bool = false
    @State var rolloutCount: String = "500"
    @State var startPlayer: String = "1"
    @State var playNim: Bool = true
    @State var progress: CGFloat = 0
    @State var running: Bool = false
    
    @State private var selectedStrength = 0
    
    var body: some View {
        VStack {
            Toggle(isOn: $playNim) {
                Text("Play Nim?")
            }
            HStack{
                Text("Hom many games?")
                
                TextField("Number of games?", text: $selectedGameCount).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            if playNim{
                HStack{
                    Text("Game size?")
                    
                    TextField("Game size?", text: $gameSize).textFieldStyle(RoundedBorderTextFieldStyle())
                }
                HStack{
                    Text("K (only for NIM)?")
                    
                    TextField("K", text: $K).textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            else{
                HStack{
                    Text("Board")
                    
                    TextField("Board", text: $ledgeBoard).textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            
            Toggle(isOn: $verbose) {
                Text("Verbose?")
            }
            
            HStack{
                Text("RolloutCount?")
                
                TextField("Rollout count?", text: $rolloutCount).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack{
                Text("Who starts?")
                
                TextField("Starting player", text: $startPlayer).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                self.startGamePLay()
            }){
                Text("Click me")
            }.disabled(running)
            
            
            ProgressBar(progress: $progress)
            
            ScrollView {
                HStack{
                    Text("\(output)")
                    Spacer()
                }
            }
        }
    }
    
    func startGamePLay(){
        output = ""
        
        let G = Int(selectedGameCount)!
        let L = Int(gameSize)!
        let rCount = Int(rolloutCount)!
        let p = Int(startPlayer)!
        let k = Int(K)!
        
        
        //let initState: game = playNim ? NIM(size: L, K: k) : Ledge(board: self.ledgeBoard.split(separator: " ").map{Int($0.description)!})
        
        if playNim{
            playGame(NIM(size: L, K: k), G, rCount, verbose, p)
        }
        else{
            playGame(Ledge(board: ledgeBoard.split(separator: " ").map{Int($0.description)!}), G, rCount, verbose, p)
        }
        
    }
    
    func playGame<g:Game>(_ initState: g, _ G: Int, _ rCount: Int, _ verbose: Bool, _ p: Int) {
        let agent = Agent(rollouts: rCount, type(of: initState))
        let players = [agent, agent]
        
        var winCount = 0
        self.running = true
        DispatchQueue.global(qos: .userInitiated).async{
            for i in 1...G{
                
                var state = initState
                var player = p == 0 ? Int.random(in: 1...2) : p
                var currPlayer = player
                while state.getActions().count > 0 {
                    currPlayer = (player - 1) % 2 + 1
                    
                    let action = players[currPlayer - 1].chooseAction(state: state)
                    
                    if self.verbose{
                        if let nim = state as? NIM{
                            let a = action as! NIMAction
                            self.printLine("Player \(currPlayer) took \(a.n), Remaining \(nim.leftovers - a.n)")
                        }
                        else if let ledge = state as? Ledge{
                            self.printLine(ledge.board.description)
                            let a = action as! LedgeAction
                            if a.start == 0{
                                self.printLine("Player \(currPlayer) picked up \(ledge.board[0] == 1 ? "copper" : "gold")")
                            }
                            else{
                                self.printLine("Player \(currPlayer) moved \(ledge.board[a.start] == 1 ? "copper" : "gold") from \(a.start) to \(a.stop)")
                            }
                        }
                    }
                    
                    state = state.doAction(action: action) as! g
                    
                    player+=1
                    
                }
                
                if currPlayer == 1{
                    winCount+=1
                }
                
                if self.verbose {
                    self.printLine("The winner is player \(currPlayer)\n")
                }
                self.progress = CGFloat(i)/CGFloat(G) * 100
            }
            
            self.printLine("Player 1 won \(round(Float(winCount)/Float(G) * 100))% of the times")
            self.running = false
        }
    }
    
    func printLine(_ s: String){
        self.output += "\(s)\n"
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
