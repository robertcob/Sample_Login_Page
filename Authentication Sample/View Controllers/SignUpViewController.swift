//
//  SignUpViewController.swift
//  Authentication Sample
//
//  Created by Robert O'Brien on 14/07/2020.
//  Copyright © 2020 Robert O'Brien. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore


class SignUpViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        errorLabel.alpha = 0
        Utilities.styleTextField(firstNameTextField)
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleTextField(emailTextField)
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signUpButton)
    }
    

 
    func validateFields() -> String? {
        // check if empty first
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        
        let clean_password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let clean_Email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Validations.isEmailValid(clean_Email) == false{
            return "Please use correct email format"
        }
        
        if Validations.isPasswordValid(clean_password) == false{
            return "Please Enter a Stronger Password"
        }
        if Validations.isPwdLenth(clean_password) == false{
            return "Please Try A Longer Password"
        }
        
        return nil
        
    }
    
    func showErrorMessage(_ message: String){
        print(message)
        errorLabel.text = message
        errorLabel.alpha = 1
        
    }
    
    func transitionToHomeScreen(){
        let homeViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.homeViewController) as? HomeViewController
        
        view.window?.rootViewController = homeViewController
        view.window?.makeKeyAndVisible()
        
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        if error != nil{
            // Something wrong with fields show error messaage..
            showErrorMessage(error!)
        }
        
        else{
            //create user
            let firstName = firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let lastName = lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let email = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            let password = passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
            Auth.auth().createUser(withEmail: email!, password: password!) { (result, err) in
                
                //check if nil or not
                if err != nil{
                    //error creating user
                    self.showErrorMessage("Error Creating User, Try Again!")
                    
                }
                else{
                    let db = Firestore.firestore()
                    
                    
                    
//                    db.collection("users").addDocument(data: ["uuid": result!.user.uid, "firstName": firstName!, "lastName": lastName!, "email": email!], completion: { (error) in
//                        if error != nil {
//                            self.showErrorMessage("error saving user data")
//
//                        }
//                    })
                    db.collection("users").document(result!.user.uid).setData(["firstName": firstName!, "lastName": lastName!, "email": email!])
                }
            }
            
            //home screen transition
            self.transitionToHomeScreen()
        }
        
    }
    
    
}
