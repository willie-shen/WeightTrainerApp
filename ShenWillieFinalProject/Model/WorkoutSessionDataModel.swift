//
//  WorkoutSessionDataModel.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation

protocol WorkoutSessionDataModel{
    
    func getTypeOfWorkout(bodyPart:String) -> [Exercise]?
    
    func getTypeOfWorkoutAt(bodyPart:String, atIndex:Int) -> Exercise?
    
    func returnWorkout() -> [Exercise]?
    func addWorkout(exercise: String, workoutType:String)
    
    func addSet(exercise:String, rep:Int, weight:Int)
    
    func numSet(exercise:String) -> Int
    
    func numWorkouts() -> Int
    
    func returnWorkoutAt(atIndex: Int) -> Exercise?
    
    //Helper Function for the tables
    func getWholeWorkoutSet(exercise:String) -> [WorkoutSet]
    
    func getWorkoutSet(atIndex:Int, exercise:String) -> WorkoutSet?
    
    func clearAll()
    
}
