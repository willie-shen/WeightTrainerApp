//
//  AddingCurrentWorkoutViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/5/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class AddingCurrentWorkoutViewController: UITableViewController {

    //Need a data structure to hold all of the workouts
    
    var currentWorkout:String = ""
    
        var workoutHistory:WorkoutHistoryModel = WorkoutHistoryModel.sharedInstance
    
    var workoutSession:WorkoutSessionModel = WorkoutSessionModel.sharedInstance
    
    //Want two models so we could add the list from one model to the other odel
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hidesBottomBarWhenPushed = true
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //we want to hide the tab Bar, have toolbar to add and finish
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        self.navigationController?.setToolbarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setToolbarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    /*override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return (workoutSession.getTypeOfWorkout(bodyPart: currentWorkout)?.count)!
        //return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workout", for: indexPath)
        
        //get an array with the currentWorkout
        


        // Configure the cell...
        //get all the workouts
        if let workout = workoutSession.getTypeOfWorkoutAt(bodyPart: currentWorkout, atIndex: indexPath.row){
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel?.text = workout.workoutName
        }
        
        
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
     //TODO: Done Button
        //When done is presssed, from the workoutSessionModel, return the list of workouts
     
        //Create a workout session that includes the list of workouts
     
        //Add it into the history model
    */
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //For segue to create new
            //have an completionHandler, which adds the added workout to the data structure of workouts
        if segue.identifier == "addExercise", let addExerciseViewController = segue.destination as? AddExerciseController{
            
            addExerciseViewController.completionHandler = { exercise in
                
                self.workoutSession.addWorkout(exercise: exercise, workoutType: self.currentWorkout)
                
                self.tableView.reloadData()
            }
            //need an action halder which adds the workout(Exercise object) into the model
            
             //then refreshes the table
        }
        
        
        
        //For segue to view sets
            //Maybe stick with a singleton model for the workouts
            //Send in the current string of the selected workout
        
        else if segue.identifier == "set", let setViewController = segue.destination as? SetViewController, let selectedIndex = tableView.indexPathForSelectedRow?.row{
            
            //Send in the current string of the selected workout
            //workoutSession.getTypeOfWorkoutAt(bodyPart: currentWorkout, atIndex: indexPath.row)
            
            setViewController.title = workoutSession.getTypeOfWorkoutAt(bodyPart: currentWorkout, atIndex: selectedIndex)?.workoutName
            
            setViewController.exercise = (workoutSession.getTypeOfWorkoutAt(bodyPart: currentWorkout, atIndex: selectedIndex)?.workoutName)!
            
            
          
            }

        }
    
    //Probably want a function for Done
            
        
    @IBAction func donePressed(_ sender: UIBarButtonItem) { //http://ios-tutorial.com/working-dates-swift/
        //getAllExercises
        let allExercises = workoutSession.returnWorkout()
        let bodyPart = currentWorkout
        let dateOfWorkout = Date()
        
        //To format our date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        dateFormatter.dateFormat = "MMMM dd, yyyy"
        
        let dateToString = dateFormatter.string(from: dateOfWorkout)
        
        let thisSession = ExerciseSession(bodyPart: bodyPart, day: dateToString, exercise: allExercises!)
        
        
        
        workoutHistory.addSession(session: thisSession!)
        
        //Set up the firebase
        var user = Auth.auth().currentUser
        
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        
        //adding the workouts into the firebase
        if(user != nil){
            ref.child("users").child((user?.uid)!).child("Workout History").child(dateToString).setValue(["Workout Date": dateToString])
            
            for exercises in allExercises!{
                ref.child("users").child((user?.uid)!).child("Workout History").child(dateToString).child("Exercises").child(exercises.workoutName).setValue(["Exercise Name":exercises.workoutName])
                
                for set in exercises.workoutSet{
                    ref.child("users").child((user?.uid)!).child("Workout History").child(dateToString).child("Exercises").child(exercises.workoutName).childByAutoId().setValue(["Weight":set.weight, "Reps":set.reps])
                }
            }
        }
        
        //Now navigate out of the workout page
       //might want to clear the SessionModel

        
        workoutSession.clearAll()
        self.navigationController?.popViewController(animated: true)
        
    }
    //Nothing else for the handler when we exit that view controller
   
        
    }
    


