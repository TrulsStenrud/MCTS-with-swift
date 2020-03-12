//
//  Agent.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

class Agent<S:Game>
{
    private let rollouts: Int
    private var visitCount: [Pair<S, S.A>: Int] = [:]
    private var winCount: [Pair<S, S.A>: Int] = [:]
    
    init(rollouts: Int, _ type: S.Type){
        self.rollouts = rollouts
        
    }
    
    func chooseAction(state: S) -> S.A {
        let actions = state.getActions()
        
        let vis = actions.map{visitCount[Pair(state, $0), default: 0]}
        let win = actions.map{winCount[Pair(state, $0), default: 0]}
        
        
        if (state as! NIM).leftovers == 6{
            var g = 3
        }
        
        for action in actions{
            for _ in 0..<rollouts{
                let reward = doRollout(state, action, myTurn: true)
                if reward == 1{
                    winCount[Pair(state, action), default: 0] += 1
                }
                
                
            }
        }
        
        let vis2 = actions.map{visitCount[Pair(state, $0), default: 0]}
        let win2 = actions.map{winCount[Pair(state, $0), default: 0]}
        
        if (state as! NIM).leftovers == 6{
            var g = 3
        }
        return actions.max{
            let pair0 = Pair(state, $0)
            let pair1 = Pair(state, $1)
            return Float(winCount[pair0, default: 0])/Float(visitCount[pair0]!)
                < Float(winCount[pair1, default: 0])/Float(visitCount[pair1]!)
            }!
        
    }
    
    func doRollout(_ state: S, _ action: S.A, myTurn: Bool) -> Int {
        let pair = Pair(state , action)
        visitCount[pair, default: 0] += 1
        
        let nextState = state.doAction(action: action) as! S
        
        let newActions = nextState.getActions()
        
        if newActions.count == 0{
            return myTurn ? 1 : -1
        }
        
        let myTurn = !myTurn
        let nextAction = newActions.randomElement()!
        let reward = doRollout(nextState, nextAction, myTurn: myTurn)
        
        if myTurn && reward == 1{
            winCount[Pair(nextState, nextAction), default: 0] += 1
        }
        else if !myTurn && reward == -1{
            winCount[Pair(nextState, nextAction), default: 0] += 1
        }
        
        return reward
    }
}
