//
//  NIM.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

class NIM : Game{
    
    typealias A = NIMAction
    typealias S = NIM
    
    let K:Int
    let leftovers: Int
    private var actions: [NIMAction]?
    
    init(size : Int, K: Int) {
        self.leftovers = size
        self.K = K
    }
    
    func getActions() -> [NIMAction] {
        if let actions = self.actions{
            return actions
        }
        
        actions = (1...K).filter{$0 <= leftovers}.map{NIMAction(n: $0)}
        return actions!
    }
    
    func doAction(action: NIMAction) -> NIM {
        if !getActions().contains(action){
            print("Really bad, cant do this action in NIM")
        }
        
        return NIM(size: leftovers - action.n, K: K)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(leftovers)
        hasher.combine(K)
    }
    static func == (lhs: NIM, rhs: NIM) -> Bool {
        return lhs.leftovers == rhs.leftovers && lhs.K == rhs.K
    }
}
