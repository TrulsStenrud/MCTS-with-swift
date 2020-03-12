//
//  ContentView.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var output : String = ""
    
    
    @State var selectedGameCount: String = "10"
    @State var gameSize: String = "10"
    @State var verbose: Bool = false
    @State var rolloutCount: String = "500"
    @State var startPlayer: String = "1"
    @State var playNim: Bool = true
    
    
    var body: some View {
        VStack {
            HStack{
                Text("Hom many games?")
                
                TextField("Number of games?", text: $selectedGameCount).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            HStack{
                Text("Game size?")
                
                TextField("Game size?", text: $gameSize).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            
            Toggle(isOn: $verbose) {
                Text("Verbose?")
            }
            
            HStack{
                Text("RolloutCount?")
                
                TextField("Rollout count?", text: $rolloutCount).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Toggle(isOn: $playNim) {
                Text("Play Nim?")
            }
            
            
            HStack{
                Text("Who starts?")
                
                TextField("Starting player", text: $startPlayer).textFieldStyle(RoundedBorderTextFieldStyle())
            }
            
            Button(action: {
                self.doStuff()
            }){
                Text("Click me")
            }
            
            ScrollView {
                HStack{
                    Text("\(output)")
                    Spacer()
                }
            }
                
            // .background(Color.red)
            
            
        }
    }
    
    func doStuff(){
        DispatchQueue.global(qos: .background).async{
            for i in 1...10000{
                print(i)
            }
            
            self.output += "Whatsup??? \n"
            
        }
        
        self.output += "First! \n"
        
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
