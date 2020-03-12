//
//  Pair.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

class Pair<S:Game, A:Action> : Hashable
{
    let state: S
    let action: A
    
    init(_ state: S, _ action: A){
        self.state = state
        self.action = action
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(state)
        hasher.combine(action)
    }
 
    static func == (lhs: Pair<S, A>, rhs: Pair<S, A>) -> Bool {
        return lhs.action == rhs.action && lhs.state == rhs.state
    }
}
