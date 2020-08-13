//
//  ViewController.swift
//  Authentication Sample
//
//  Created by Robert O'Brien on 13/07/2020.
//  Copyright © 2020 Robert O'Brien. All rights reserved.
//
import FirebaseAuth
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var continueButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //all initial setup
        
        //make error label invisible
        errorLabel.alpha = 0
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        Utilities.styleFilledButton(continueButton)
        
        
    }
    
    func validateFields() -> String? {
    // check if empty first
        if  emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        
    
        }
        return nil
    }
    
    func showErrorMessage(_ message: String){
        print(message)
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    


    @IBAction func continueButtonTapped(_ sender: Any) {
        let error = validateFields()
        
        if error != nil{
            // Something wrong with fields show error messaage..
            showErrorMessage(error!)
        }
        else{
        let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //Sign user in
        
        Auth.auth().signIn(withEmail: email!, password: password!) { (result, error) in
            if error != nil{
                //issue signing in
                self.showErrorMessage("Email or Password is incorrect, Please Try Again")
            }
            
            else{
                let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
                
                self.view.window?.rootViewController = homeViewController
                self.view.window?.makeKeyAndVisible()
            }
            }
        }
    }


}
