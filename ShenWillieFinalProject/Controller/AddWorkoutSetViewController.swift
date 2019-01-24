//
//  AddWorkoutSetViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 12/6/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit

class AddWorkoutSetViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.isEnabled = false
        submitButton.alpha = 0.5
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var completionHandler:((_ weight:String, _ rep:String) -> Void)?
    
    @IBOutlet weak var weightTextField: UITextField!
    
    
    @IBOutlet weak var repTextField: UITextField!
    
    
    @IBOutlet weak var submitButton: UIButton!
    
    @IBAction func backgroundPressed(_ sender: Any) {
        
        weightTextField.resignFirstResponder()
        repTextField.resignFirstResponder()
    }

    @IBAction func submitPressed(_ sender: UIButton) {
        if let weight = weightTextField.text, let rep = repTextField.text, let completionHandler = completionHandler{completionHandler(weight, rep)}
        self.navigationController?.popViewController(animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case weightTextField:
            weightTextField.resignFirstResponder()
            repTextField.becomeFirstResponder()
        case repTextField:
            repTextField.resignFirstResponder()
        default:
            break
        }
        
        return true
    }
    
    //Recycled code from AddQuotes Example
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        if let text = textField.text, let textRange = Range(range, in: text){
            
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            
            if textField == weightTextField{
                enableSubmitButton(weightText: updatedText, repText: repTextField.text!)
            }else if textField == repTextField{
                enableSubmitButton(weightText: weightTextField.text!, repText: updatedText)
            
            
        }
        
       
    }
        return true
        
    }
    
        func enableSubmitButton(weightText:String, repText:String){
            
            self.submitButton.isEnabled = (weightText.count > 0 && repText.count > 0)
            
            if(self.submitButton.isEnabled){
                self.submitButton.alpha = 1
            }else{
                self.submitButton.alpha = 0.5
            }
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
