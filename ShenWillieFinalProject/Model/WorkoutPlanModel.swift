//
//  WorkoutPlanModel.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/3/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation

class WorkoutPlanModel: WorkoutPlanDataModel{

    //String Keys, for the dictionary for our data persistence
    
    //Recycling Code from Homework 5
    var filepath: String
    
    var kWorkoutType = "WorkoutKey"
    var kWorkoutName = "WorkoutName"
    var kRangeOfReps = "RangeOfReps"
    var kNumSets = "NumSets"
    
    //Singleton
    static let sharedInstance = WorkoutPlanModel()
    
    //Data Structure to keep the workout plan
    private var workouts:[WorkoutPlan]
    
    //keys for data persistence
    
    init(){
        workouts = [WorkoutPlan]()
        
        //recycled code from HW5:Flashcards
        
        let manager = FileManager.default
        var url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        filepath = url!.appendingPathComponent("workoutPlanPlist.plist").path
        
        if manager.fileExists(atPath: filepath){
            
            let workoutPlanArray = NSArray(contentsOfFile: filepath)
            
            if let workoutPlanA = workoutPlanArray{
                for dict in workoutPlanA{
                    let workoutPlanDict:[String:String] = dict as! [String:String]
                    
                    workouts.append(WorkoutPlan(workoutType: workoutPlanDict[kWorkoutType]!, workoutName: workoutPlanDict[kWorkoutName]!, rangeOfReps: workoutPlanDict[kRangeOfReps]!, numSets: Int(workoutPlanDict[kNumSets]!)!))
                    
                }
            }
        }
    }
    
    //returns the number of the workouts
    func numberOfWorkouts() -> Int {
        return workouts.count
    }
    
    func workout(atIndex: Int) -> WorkoutPlan? {
        return workouts[atIndex]
    }
    
    func numOfArm() -> Int {
        var countArms = 0
        
        for i in workouts{
            if i.workoutType == "Arms"{
                countArms = countArms + 1
            }
        }
        
        return countArms
    }
    
    func numOfChest() -> Int {
        var countChest = 0
        
        for i in workouts{
            if i.workoutType == "Chest"{
                countChest = countChest + 1
            }
        }
        
        return countChest
    }
    
    func numOfShoulders() -> Int {
        var countShoulders = 0
        
        for i in workouts{
            if i.workoutType == "Shoulders"{
                countShoulders = countShoulders + 1
            }
        }
        
        return countShoulders
    }
    
    func numOfBack() -> Int {
        var countBack = 0
        
        for i in workouts{
            if i.workoutType == "Back"{
                countBack = countBack + 1
            }
        }
        
        return countBack
    }
    
    func numOfAbs() -> Int {
        var countAbs = 0
        
        for i in workouts{
            if i.workoutType == "Abs"{
                countAbs = countAbs + 1
            }
        }
        
        return countAbs
    }
    
    func numOfLegs() -> Int {
        var countLegs = 0
        
        for i in workouts{
            if i.workoutType == "Legs"{
                countLegs = countLegs + 1
            }
        }
        
        return countLegs
    }
    
    func allArms() -> [WorkoutPlan]{
        
        var armWorkouts:[WorkoutPlan] = [WorkoutPlan]()
        for i in workouts{
            if i.workoutType == "Arms"{
                armWorkouts.append(i)
            }
        }
        
        return armWorkouts
    }
    func allChest() -> [WorkoutPlan]{
        var chestWorkouts:[WorkoutPlan] = [WorkoutPlan]()
        for i in workouts{
            if i.workoutType == "Chest"{
                chestWorkouts.append(i)
            }
        }
        
        return chestWorkouts
        
    }
    func allShoulders() -> [WorkoutPlan]{
        var shoulderWorkouts:[WorkoutPlan] = [WorkoutPlan]()
        for i in workouts{
            if i.workoutType == "Shoulders"{
                shoulderWorkouts.append(i)
            }
        }
        
        return shoulderWorkouts
    }
    func allBack() -> [WorkoutPlan]{
        var backWorkouts:[WorkoutPlan] = [WorkoutPlan]()
        for i in workouts{
            if i.workoutType == "Back"{
                backWorkouts.append(i)
            }
        }
        
        return backWorkouts
    }
    func allAbs() -> [WorkoutPlan]{
        var abWorkouts:[WorkoutPlan] = [WorkoutPlan]()
        for i in workouts{
            if i.workoutType == "Abs"{
                abWorkouts.append(i)
            }
        }
        
        return abWorkouts
    }
    func allLegs() -> [WorkoutPlan]{
        var legWorkouts:[WorkoutPlan] = [WorkoutPlan]()
        for i in workouts{
            if i.workoutType == "Legs"{
                legWorkouts.append(i)
            }
        }
        
        return legWorkouts
    }
    
    func insert(workoutType: String, workoutName: String, rangeOfReps: String, numSets: Int) {
        workouts.append(WorkoutPlan(workoutType: workoutType, workoutName: workoutName, rangeOfReps: rangeOfReps, numSets: numSets))
        
        save()
    }
    
    func removeWorkout(atIndex: Int){
        workouts.remove(at: atIndex)
        
        save()
    }
    
    private func save(){
        
        var workoutPlanArray = [[String:String]]()
        
        for workout in workouts{ //https://stackoverflow.com/questions/24161336/convert-int-to-string-in-swift
            let exercise = [kWorkoutType:workout.workoutType, kWorkoutName:workout.workoutName, kRangeOfReps:workout.rangeOfReps, kNumSets:String(workout.numSets)]
            
            workoutPlanArray.append(exercise)
        }
        
        (workoutPlanArray as NSArray).write(toFile: filepath, atomically: true)
    }
}
