//
//  SetViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit

class SetViewController: UITableViewController {
    
        var workoutSession:WorkoutSessionModel = WorkoutSessionModel.sharedInstance
    
    var exercise:String = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

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
        //print(workoutSession.numSet(exercise: exercise))
        return workoutSession.numSet(exercise: exercise)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutSet", for: indexPath)

        // Configure the cell...
      
        if let workoutSet = workoutSession.getWorkoutSet(atIndex: indexPath.row, exercise: exercise){
            cell.textLabel?.numberOfLines = 0
            cell.textLabel!.text = "Weight:\(workoutSet.weight) \t Reps:\(workoutSet.reps)"
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

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
     
     //segue identifier is called addSet
        if segue.identifier == "addSet", let addWorkoutSetViewController = segue.destination as? AddWorkoutSetViewController{
            
            //After we get the values from the View Controller, we want to add it into the data structure (completionHandler)
            addWorkoutSetViewController.completionHandler = {weight, rep in
                
                
                self.workoutSession.addSet(exercise: self.exercise, rep: Int(rep)!, weight: Int(weight)!)
                

                self.tableView.reloadData()
                
            }
        }
     
     
     
     //After that, we want to update the table view
    }
    

}
