//
//  SignUpViewController.swift
//  ShenWillieFinalProject
//
//  Created by Willie Shen on 11/28/18.
//  Copyright © 2018 Willie Shen. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    
    
    @IBOutlet weak var reenterPasswordTextField: UITextField!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelled(_ sender: UIBarButtonItem) {
            self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func backgroundTouched(_ sender: UITapGestureRecognizer) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        usernameTextField.resignFirstResponder()
        reenterPasswordTextField.resignFirstResponder()
    
    }
    //sign up handler should be almost identical to the class example
  
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        
        //Have checkers to make sure input valid/not blank
        guard let username = usernameTextField.text else{
            return
        }
        guard let email = emailTextField.text else {
            
            //errorLabel.text = "ERROR: Email not provided"
            return
        }
        
        guard let password = passwordTextField.text else{
            return
        }
        
        guard let reenterPassword = reenterPasswordTextField.text else{
            return
        }

        if(username == ""){
            self.errorLabel.text = "ERROR: Username blank"
            return
        }
        
        if(email == ""){
            self.errorLabel.text = "ERROR: Email blank"
            return
        }
        if(password == ""){
            self.errorLabel.text = "ERROR: Password blank"
            return
        }
        if(reenterPassword == ""){
            self.errorLabel.text = "ERROR: Re-enter your password"
            return
        }
        
        if(password != reenterPassword){
            self.errorLabel.text = "ERROR: Passwords don't match"
            return
        }
        

        
        Auth.auth().createUser(withEmail: email, password: password){
            user, error in
            
            //print("Success")
            if error == nil && user != nil{
                var ref: DatabaseReference!
                
                ref = Database.database().reference()
                //https://stackoverflow.com/questions/50317730/value-of-type-authdataresult-has-no-member-uid-error/50419010
                ref.child("users").child((user?.user.uid)!).setValue(["username": email])
                Helper.helper.switchToMainApp()
            }//handle error
            else{
                //print("Error: \(error!.localizedDescription)")
                self.errorLabel.text = "Error: \(error!.localizedDescription)"
            }
            
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField{
        case usernameTextField:
            usernameTextField.resignFirstResponder()
            emailTextField.becomeFirstResponder()
        case emailTextField:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case passwordTextField:
            passwordTextField.resignFirstResponder()
            reenterPasswordTextField.becomeFirstResponder()
        case reenterPasswordTextField:
            reenterPasswordTextField.resignFirstResponder()
            break;
        default:
            break
        }
        return true
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
