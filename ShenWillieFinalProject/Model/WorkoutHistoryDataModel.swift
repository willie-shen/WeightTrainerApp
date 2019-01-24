//
//  WorkoutHistoryDataModel.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation

protocol WorkoutHistoryDataModel{
    
    func addSession(session:ExerciseSession)
    
    func numSessions() -> Int
    
    func getSessionAt(atIndex: Int) ->ExerciseSession?
}
