//
//  Ledge.swift
//  MCTS
//
//  Created by Truls Stenrud on 12/03/2020.
//  Copyright © 2020 Truls Stenrud. All rights reserved.
//

import Foundation

class Ledge : Game{
    
    typealias A = LedgeAction
    typealias S = Ledge
    
    let board :[Int]
    var actions: [A]?
  
    init(board: [Int]) {
        self.board = board
    }
    
    
    func getActions() -> [Ledge.A] {
        if let actions = self.actions{
            return actions
        }
        
        if !board.contains(2){
            actions = []
            return actions!
        }
        
        var actions: [LedgeAction] = []
        
        if board[0] != 0{
            actions.append(LedgeAction(start: 0, stop: 0))
            if board[0] == 2{
                return actions
            }
            
        }
        
        var coinToMove: Int = -1
        for i in (0..<board.count).reversed(){
            if board[i] == 0{
                if coinToMove != -1{
                    actions.append(LedgeAction(start: coinToMove, stop: i))
                }
            }
            else{
                coinToMove = i
            }
        }
        
        self.actions = actions
        return actions
    }
    
    func doAction(action: LedgeAction) -> Ledge {
        if !getActions().contains(action) {
            print("Really bad, cant do this action in Ledge")
        }
        var newBoard = board
        
        if(action.start == 0){
            newBoard[0] = 0
        }
        else{
            newBoard[action.stop] = newBoard[action.start]
            newBoard[action.start] = 0
        }
        
        return Ledge(board: newBoard)
    }
    static var counter = 0
    func hash(into hasher: inout Hasher) {
        hasher.combine(board)
    }
    
    static func == (lhs: Ledge, rhs: Ledge) -> Bool {
        return lhs.board == rhs.board
    }
}
