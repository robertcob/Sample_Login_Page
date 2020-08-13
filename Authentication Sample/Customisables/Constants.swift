//
//  Constants.swift
//  Authentication Sample
//
//  Created by Robert O'Brien on 20/07/2020.
//  Copyright © 2020 Robert O'Brien. All rights reserved.
//

import Foundation

struct Constants{
    
    struct Storyboard {
        static let homeViewController = "HomeVC"
        static let loginViewController = "LoginVC"
        
    }
    
    struct User_Info {
        var firstName: String
        var lastName: String
        var email: String
        
        
        init(firstName: String, lastName :String, email:String) {
            self.firstName = firstName
            self.lastName = lastName
            self.email = email
        }
        
        public func getFirstName() -> String{
            return self.firstName
        }
        
        public func getLastName() -> String{
            return self.lastName
        }
        
        public func getEmail() -> String{
            return self.email
        }
        
    }
    
    
}
