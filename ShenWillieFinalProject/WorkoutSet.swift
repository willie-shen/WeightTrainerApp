//
//  File.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation
import UIKit
import os.log
//https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html
class WorkoutSet:NSObject, NSCoding{ //Need NSCode/NSObject for serialization

    
    private(set) var weight:Int
    private(set) var reps:Int
    
    struct PropertyKey{
        static let kWeight = "kWeight"
        static let kReps = "kReps"
        
    }
    
    init(weight: Int, reps:Int){
        self.weight = weight
        self.reps = reps
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(weight, forKey: PropertyKey.kWeight)
        aCoder.encode(reps, forKey: PropertyKey.kReps)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let weight = aDecoder.decodeObject(forKey: PropertyKey.kWeight) as? Int else{
            os_log("Unable to decode the weight for a WorkoutSet object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        guard let reps = aDecoder.decodeObject(forKey: PropertyKey.kReps) as? Int else{
            os_log("Unable to decode the reps for a WorkoutSet object.", log: OSLog.default, type: .debug)
            return nil
        }
        
        self.init(weight:weight, reps:reps)
    }
    
}
