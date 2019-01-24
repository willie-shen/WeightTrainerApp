//
//  Exercise.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation
import UIKit
import os.log

//https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html
class Exercise:NSObject, NSCoding{ //need NSCode/NSObject for serialization
    
    struct PropertyKey{ //keyName
        static let kWorkoutName = "kWorkoutName"
        static let kWorkoutType = "kWorkoutType"
        static let kWorkoutSet = "KWorkoutSet"
    }
    
    private(set) var workoutName:String
    private(set) var workoutType:String
    public var workoutSet:[WorkoutSet] = [WorkoutSet]()
    
    init(workoutName:String, workoutType:String){
        self.workoutName = workoutName
        self.workoutType = workoutType
    }
    
    init(workoutName:String, workoutType:String, workoutSet:[WorkoutSet]){
        self.workoutName = workoutName
        self.workoutType = workoutType
        self.workoutSet = workoutSet
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(workoutName, forKey: PropertyKey.kWorkoutName)
        aCoder.encode(workoutType, forKey: PropertyKey.kWorkoutType)
        aCoder.encode(workoutSet, forKey: PropertyKey.kWorkoutSet)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let exerciseName = aDecoder.decodeObject(forKey: PropertyKey.kWorkoutName) as? String else{
            os_log("Unable to decode the workoutName for an exercise object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let exerciseType = aDecoder.decodeObject(forKey: PropertyKey.kWorkoutType) as? String else{
            os_log("Unable to decode the workoutType for an exercise object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let exerciseSet = aDecoder.decodeObject(forKey: PropertyKey.kWorkoutSet) as? [WorkoutSet] else{
            os_log("Unable to decode the workoutSet for an exercise object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(workoutName:exerciseName, workoutType:exerciseType, workoutSet:exerciseSet)
    }
    
}
