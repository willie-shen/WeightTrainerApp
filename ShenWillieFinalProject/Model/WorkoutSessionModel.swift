//
//  WorkoutSessionModel.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation

class WorkoutSessionModel:WorkoutSessionDataModel{

    

    
    
    static let sharedInstance = WorkoutSessionModel()
    
    private var exercises:[Exercise]
    
    init(){
        exercises = [Exercise]()
    }
    
    func getTypeOfWorkout(bodyPart:String) -> [Exercise]?{
        
        var workouts:[Exercise] = [Exercise]()
        for i in exercises{
            if(i.workoutType==bodyPart){
                workouts.append(i)
            }
        }
        
        return workouts
    }
    
    func getTypeOfWorkoutAt(bodyPart:String, atIndex:Int) -> Exercise?{
        return getTypeOfWorkout(bodyPart: bodyPart)![atIndex]
    }
    
    func returnWorkout() -> [Exercise]? {
        return exercises
    }
    
    func returnWorkoutAt(atIndex: Int) -> Exercise?{
        return exercises[atIndex]
    }
    
    func addWorkout(exercise: String, workoutType:String) {
        exercises.append(Exercise(workoutName:exercise, workoutType:workoutType))
    }
    
    
    func addSet(exercise: String, rep: Int, weight: Int) {
        
        var i:Int = 0
        
        while(exercises[i].workoutName != exercise){
            i = i+1
        }
        
        exercises[i].workoutSet.append(WorkoutSet(weight: weight, reps: rep))
    }
    
    func numSet(exercise: String) -> Int {
        var size:Int!
        for i in exercises{
            if(i.workoutName==exercise){
                size = i.workoutSet.count
            }
        }
        
        return size
    }
    
    func getWholeWorkoutSet(exercise:String) -> [WorkoutSet]{
        var setOfExercise:[WorkoutSet] = [WorkoutSet]()
        
        for i in exercises{
            if i.workoutName == exercise{
                setOfExercise = i.workoutSet
            }
        }
        
        return setOfExercise
    }
    
    //Helper function to get exercise set
    func getWorkoutSet(atIndex:Int, exercise:String) -> WorkoutSet?{
        return getWholeWorkoutSet(exercise: exercise)[atIndex]
    }
    
    func numWorkouts() -> Int {
        return exercises.count
    }
    
    //Need to do this to reset the workout session, so we don't have workouts from next session in our next workouts
    func clearAll(){ //https://iswift.org/cookbook/remove-all-items-from-array
        exercises.removeAll()
    }
    
    
    
}
