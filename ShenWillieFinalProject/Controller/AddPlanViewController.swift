//
//  AddPlanViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/3/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit

class AddPlanViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var workoutTextField: UITextField!
    
    
    @IBOutlet weak var numSetTextField: UITextField!
    
    
    @IBOutlet weak var repTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    //completion handler
    
    var completionHandler: ((_ workout:String, _ numSets:String, _ range:String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func backgroundPressed(_ sender: UITapGestureRecognizer) {
        workoutTextField.resignFirstResponder()
        numSetTextField.resignFirstResponder()
        repTextField.resignFirstResponder()
    }
    
    
    @IBAction func submitPressed(_ sender: Any) {
        if let workout = workoutTextField.text, let numSets = numSetTextField.text, let range = repTextField.text, let completionHandler = completionHandler{ completionHandler(workout, numSets, range)
            
            self.navigationController?.popViewController(animated: true)
        }
        
        
    }
    
    //Delegate pattern for the text fields
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
            case workoutTextField:
                workoutTextField.resignFirstResponder()
                numSetTextField.becomeFirstResponder()
            case numSetTextField:
                numSetTextField.resignFirstResponder()
                repTextField.becomeFirstResponder()
            case repTextField:
                repTextField.resignFirstResponder()
                break
            default:
                break
            
        }
        
        return true
        
    }
    
    //Recycled code from AddQuotes Example
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if let text = textField.text, let textRange = Range(range, in: text){
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if textField == workoutTextField{
                enableSubmitButton(workoutText: updatedText, numSetText: numSetTextField.text!, repText: repTextField.text!)
            }else if textField == numSetTextField{
                enableSubmitButton(workoutText: workoutTextField.text!, numSetText: updatedText, repText: repTextField.text!)
            }else if textField == repTextField{
                enableSubmitButton(workoutText: workoutTextField.text!, numSetText: numSetTextField.text!, repText: updatedText)
            }
            
        }
        
        return true;
    }
        
    
    
    
    func enableSubmitButton(workoutText:String, numSetText:String, repText:String){
        
        self.submitButton.isEnabled = (workoutText.count > 0 && numSetText.count > 0 && repText.count > 0)
        
        if(self.submitButton.isEnabled){
            self.submitButton.alpha = 1
        }else{
            self.submitButton.alpha = 0.5
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
