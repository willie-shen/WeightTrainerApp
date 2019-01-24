//
//  WorkoutPlanDataModel.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/3/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation

protocol WorkoutPlanDataModel{
    
    func numberOfWorkouts() -> Int
    
    func numOfArm() -> Int
    
    func numOfChest() -> Int
    
    func numOfBack() -> Int
    
    func numOfShoulders() -> Int
    
    func numOfAbs() -> Int
    
    func numOfLegs() -> Int
    
    func workout(atIndex: Int) -> WorkoutPlan?
    
    func insert(workoutType:String, workoutName:String, rangeOfReps:String, numSets:Int)
    
    func removeWorkout(atIndex: Int)
    
    func allArms() -> [WorkoutPlan]
    func allChest() -> [WorkoutPlan]
    func allShoulders() -> [WorkoutPlan]
    func allBack() -> [WorkoutPlan]
    func allAbs() -> [WorkoutPlan]
    func allLegs() -> [WorkoutPlan]
    
}
