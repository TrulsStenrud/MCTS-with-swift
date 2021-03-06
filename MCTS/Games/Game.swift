//
//  File.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

protocol Game : Hashable
{
    associatedtype A: Action
    associatedtype S: Game
    
    func getActions() -> [A]
    
    func doAction(action: A) -> S
}


