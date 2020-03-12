//
//  LedgeAction.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

class LedgeAction: Action {
    static func == (lhs: LedgeAction, rhs: LedgeAction) -> Bool {
        return lhs.start == rhs.start && lhs.stop == rhs.stop
    }
    
    
    let start: Int
    let stop: Int
    init(start: Int, stop: Int){
        self.start = start
        self.stop = stop
    }
    
    
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(start)
        hasher.combine(stop)
    }
}
