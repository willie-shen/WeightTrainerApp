//
//  ShowPlansViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/1/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit
import MessageUI
import Firebase
import FirebaseDatabase

class ShowPlansViewController: UITableViewController, MFMessageComposeViewControllerDelegate {
    
    var workoutType:String!
    
    var workoutPlan:WorkoutPlanModel = WorkoutPlanModel.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //https://stackoverflow.com/questions/28777943/hide-tab-bar-in-ios-swift-app
//        self.tabBarController?.tabBar.isHidden = true;
        self.hidesBottomBarWhenPushed = true
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

    // MARK: - Table view data source

   /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }*/

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //number of rows depends on what kind of workout
        var numRows:Int!
        
        switch workoutType{
        case "Arms":
            numRows = workoutPlan.numOfArm()
        case "Shoulders":
            numRows = workoutPlan.numOfShoulders()
        case "Chest":
            numRows = workoutPlan.numOfChest()
        case "Back":
            numRows = workoutPlan.numOfBack()
        case "Abs":
            numRows = workoutPlan.numOfAbs()
        case "Legs":
            numRows = workoutPlan.numOfLegs()
        default:
            break
        }
        
        
        
        return numRows
    }

    //https://www.youtube.com/watch?v=HIzf8brnfWE
    //This is used for the share feature, which we send a text message to our people in our address book. Opens up a Message View
    @IBAction func sharePushed(_ sender: UIBarButtonItem) {
        var workouts:[WorkoutPlan]!
        
        switch workoutType{
        case "Arms":
            workouts = workoutPlan.allArms()
        case "Shoulders":
            workouts = workoutPlan.allShoulders()
        case "Chest":
            workouts = workoutPlan.allChest()
        case "Back":
            workouts = workoutPlan.allBack()
        case "Abs":
            workouts = workoutPlan.allAbs()
        case "Legs":
            workouts = workoutPlan.allLegs()
        default:
            break
        }
        
        //https://www.youtube.com/watch?v=RLpFm9uBwCI @ 7:32
        //We want to share this via text message
        
        //Have the activity view pop up UIActivityView
        
        var list:String = ""
        
        for i in workouts{
            list += "Workout:\(i.workoutName) \nSets:\(i.numSets) \nReps:\(i.rangeOfReps) \n \n"
        }
        
       
        var message: String = ""
        if let exercise = workoutType{
             message = "Here are my workouts for \(exercise): \n" + list
        }
        
        
        
        let activityViewController = UIActivityViewController(activityItems: [message], applicationActivities: nil)
        activityViewController.excludedActivityTypes = [.copyToPasteboard]
        self.present(activityViewController, animated: true)
        
        //https://nshipster.com/uiactivityviewcontroller/
        
        /*if(MFMessageComposeViewController.canSendText()){
            let controller = MFMessageComposeViewController()
            controller.messageComposeDelegate = self as? MFMessageComposeViewControllerDelegate
            controller.disableUserAttachments()
            
           
            
            self.present(controller, animated: true, completion: nil)
        }*/

        
        
    }
    //This is used for handling the Message sending View
    //https://github.com/ioscreator/ioscreator/blob/master/IOS12SendiMessageTutorial/IOS12SendiMessageTutorial/ViewController.swift
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercise", for: indexPath)
        
        var workouts:[WorkoutPlan]!
        // Configure the cell...
        
        //check what type of workout do we have
        switch workoutType{
        case "Arms":
            workouts = workoutPlan.allArms()
        case "Shoulders":
            workouts = workoutPlan.allShoulders()
        case "Chest":
            workouts = workoutPlan.allChest()
        case "Back":
            workouts = workoutPlan.allBack()
        case "Abs":
            workouts = workoutPlan.allAbs()
        case "Legs":
            workouts = workoutPlan.allLegs()
        default:
            break
        }
        
        let exercise = workouts[indexPath.row]
        
            cell.textLabel?.numberOfLines = 0
            cell.textLabel!.text = "Workout: \(exercise.workoutName)"
            cell.detailTextLabel?.text = "Number of Sets: \(exercise.numSets)\t Reps: \(exercise.rangeOfReps)"
        
       
        

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            workoutPlan.removeWorkout(atIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

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
     
        if segue.identifier == "addPlan", let addPlanViewController = segue.destination as? AddPlanViewController{
            
            addPlanViewController.completionHandler = { workout, numSets, range in
                
                //https://stackoverflow.com/questions/24115141/converting-string-to-int-with-swift
                
                //https://firebase.google.com/docs/auth/ios/manage-users#get_the_currently_signed-in_user
                
                var user = Auth.auth().currentUser
                
                var ref: DatabaseReference!
                
                ref = Database.database().reference()
                
                if(user != nil){
                    ref.child("users").child((user?.uid)!).child("Workout Plan").child(self.workoutType).childByAutoId().setValue(["Workout Name": workout, "Range of Reps": range, "Number of Sets": numSets])
                }
                
                self.workoutPlan.insert(workoutType: self.workoutType, workoutName: workout, rangeOfReps: range, numSets: Int(numSets)!)
                
            }
            
            self.tableView.reloadData()
        }

     
    }
    

}
