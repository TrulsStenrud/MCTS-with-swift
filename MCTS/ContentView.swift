//
//  ContentView.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var clickCount : Int = 0
    @State var output : String = "0"
    var body: some View {
        VStack {
            Text("\(clickCount)")
            Button(action: {
                self.clickCount += 1
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
                
            .background(Color.red)
            
            
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
