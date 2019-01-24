//
//  WorkoutHistoryModel.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation
import os.log

class WorkoutHistoryModel:WorkoutHistoryDataModel{
    
//https://developer.apple.com/library/archive/referencelibrary/GettingStarted/DevelopiOSAppsSwift/PersistData.html for serialization
    
    //Since this is the main class for storing history, we will save/load on this
    
    static let sharedInstance = WorkoutHistoryModel()

    
    private var sessions:[ExerciseSession]!
    
    init(){
       
        
        //data persistence loading
        if let savedWorkouts = load(){
            sessions = savedWorkouts
        }else{
            
             sessions = [ExerciseSession]()
        }
    }
    
    func addSession(session: ExerciseSession) {
        self.sessions.append(session)
        
        //be sure to save into the core data
        save()
    }
    
    func numSessions() -> Int {
        return sessions.count
    }
    
    func getSessionAt(atIndex: Int) ->ExerciseSession?{
        return sessions[atIndex]
    }
    
    private func save(){//save the data
        
        print(ExerciseSession.ArchiveURL.path)
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(sessions, toFile:ExerciseSession.ArchiveURL.path)
        if isSuccessfulSave{
            os_log("Workouts saved successfully", log: OSLog.default, type:.debug)
        }else{
            os_log("Failed to save workouts...", log:OSLog.default, type:.error)
        }
    }
    
    //load the exercise sessions
    private func load() -> [ExerciseSession]?{
        
        if (NSKeyedUnarchiver.unarchiveObject(withFile: ExerciseSession.ArchiveURL.path) as? [ExerciseSession]) == nil{
            print("Trying to load, but failed")
            return nil
        }
        
        return (NSKeyedUnarchiver.unarchiveObject(withFile: ExerciseSession.ArchiveURL.path) as? [ExerciseSession])!
    }
}
