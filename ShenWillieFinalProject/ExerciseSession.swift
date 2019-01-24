//
//  ExerciseSession.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation
import UIKit
import os.log

//https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html

class ExerciseSession:NSObject, NSCoding{ //Need NSCode/NSObject for serialization
    
    //Need the file paths, only for this file, since this holds pretty much everything
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("ExerciseSession")
    
    struct PropertyKey{ //keyName
        static let body = "body"
        static let date = "date"
        static let workouts = "workouts"
    }
   
    
    private(set) var bodyPart:String
    private(set) var day:String
    
    public var exercises:[Exercise]
    
    init?(bodyPart:String, day:String, exercise:[Exercise]){
        self.bodyPart = bodyPart
        self.day = day
        self.exercises = exercise
    }
    
    //MARK: NSCoding
    
    func encode(with aCoder: NSCoder){
       aCoder.encode(bodyPart, forKey: PropertyKey.body)
       aCoder.encode(day, forKey: PropertyKey.date)
        aCoder.encode(exercises, forKey:PropertyKey.workouts)
        
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        
        guard let bodyWorked = aDecoder.decodeObject(forKey: PropertyKey.body) as? String else{
            os_log("Unable to decode the bodyPart for a ExerciseSession Object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let dayWorked = aDecoder.decodeObject(forKey: PropertyKey.date) as? String else{
            os_log("Unable to decode the day for a ExerciseSession Object.", log: OSLog.default, type: .debug)
            return nil
        }
        
    
        
        guard let exercisesDone = aDecoder.decodeObject(forKey: PropertyKey.workouts) as? [Exercise] else{
            os_log("Unable to decode the exercises for a ExerciseSession Object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        //call the initializer
        
        self.init(bodyPart:bodyWorked, day:dayWorked, exercise:exercisesDone)
        
    }
    
}
