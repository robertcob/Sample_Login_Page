//
//  HomeViewController.swift
//  Authentication Sample
//
//  Created by Robert O'Brien on 14/07/2020.
//  Copyright © 2020 Robert O'Brien. All rights reserved.
//

import UIKit
import FirebaseFirestore
import Firebase
import FirebaseAuth

class HomeViewController: UIViewController {
    

    @IBOutlet weak var firstNameLabel: UILabel!
 
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    override func viewDidLoad() {
        
        //check user logged in
        Auth.auth().addStateDidChangeListener(){Auth, user in
            if user != nil{
                //if user logged in, display info
                
                self.returnUserData()
//                print("PRINTING USER DATA", Constants.userData.firstName, Constants.userData.lastName,Constants.User_Info.email )

                
    
            }
            else{
                
                //user not signed in send to login page
                let loginViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.loginViewController) as? HomeViewController
                
                self.view.window?.rootViewController = loginViewController
                self.view.window?.makeKeyAndVisible()
            }
            
        }
        
        super.viewDidLoad()
       
        

        // Do any additional setup after loading the view.
    }
    

    

    func returnUserData(){
        
        let db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            let uid = user.uid
            print(uid)
            
            let docRef = db.collection("users").document(uid)
            
            docRef.getDocument { (document, error) in
                if let document = document, document.exists{
                    let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                    print("Document data: \(dataDescription)")
                    let user_Data = document.data()

                    let firstName = user_Data!["firstName"] as! String
                    let lastName = user_Data!["lastName"] as! String
                    let email = user_Data!["email"] as! String
                    
                    
                    
                    let user_Info = Constants.User_Info.init(firstName: firstName, lastName: lastName, email: email)
                    
                    self.firstNameLabel.text = user_Info.getFirstName()
                    self.lastNameLabel.text = user_Info.getLastName()
                    self.emailLabel.text = user_Info.getEmail()
                    
                    
                }
                else{
                    print("Document does not exist")
                }
            }
            
            
            
        }
        
    
            
        }
    



}
