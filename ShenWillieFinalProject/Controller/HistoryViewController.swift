//
//  HistoryViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/1/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var workoutHistory:WorkoutHistoryModel = WorkoutHistoryModel.sharedInstance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hidesBottomBarWhenPushed = false

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    //Recycled from hw5
    override func viewWillAppear(_ animated: Bool) {
        
        self.tableView.reloadData()
        
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
        //return 0
        
        return workoutHistory.numSessions()
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "dates", for: indexPath)

        // Configure the cell...
        if let date = workoutHistory.getSessionAt(atIndex: indexPath.row){
            
            cell.textLabel?.numberOfLines = 0
            cell.textLabel!.text = date.day
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
        
        
        //grab index of the selected row,
            //use that and get the list of exercises
            //And send it to the next view controller
        
        if segue.identifier == "pastWorkouts", let showPastWorkoutViewController = segue.destination as? ShowPastWorkoutViewController, let dayIndex = tableView.indexPathForSelectedRow?.row{
            
            showPastWorkoutViewController.exercises = workoutHistory.getSessionAt(atIndex: dayIndex)?.exercises
           
            //print(parts[partIndex])
        }
    }
    

}
