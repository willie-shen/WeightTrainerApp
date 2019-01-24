//
//  Helper.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 11/30/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

//will be pretty much the same as the FirebaseAuthenticationUI example

class Helper{
    
    static let helper = Helper()
    
    func switchToMainApp(){
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainAppViewController = storyboard.instantiateViewController(withIdentifier: "MainAppVC")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = mainAppViewController
    }
    
    func switchToLogInScreen(){
        
        do{
            try Auth.auth().signOut()
        }catch let error{
            
        }
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let mainAppViewController = storyboard.instantiateViewController(withIdentifier: "LogInViewController")
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        appDelegate.window?.rootViewController = mainAppViewController
    }
}
