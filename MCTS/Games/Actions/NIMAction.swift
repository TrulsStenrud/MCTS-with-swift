//
//  NIMAction.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

class NIMAction: Action{
    
    let n: Int
    
    init(n: Int){
        self.n = n
    }
    
    static func == (lhs: NIMAction, rhs: NIMAction) -> Bool {
        return lhs.n == rhs.n
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(n)
    }
}
