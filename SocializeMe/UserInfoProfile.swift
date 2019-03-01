//
//  UserInfoProfile.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/1/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation

class UserInfoProfile {
    private var email: String
    private var gender: String
    private var name: String
    private var occupation: String
    
    init() {
        self.email = ""
        self.gender = ""
        self.name = ""
        self.occupation = ""
    }
    
    func print() {
        Swift.print("\(name) \n \(gender) \n \(email) \n \(occupation)")
    }
    
    func setName(_ name: String) {
        self.name = name
    }
    
    func setGender(_ gender: String) {
        self.gender = gender
    }
    
    func setEmail(_ email: String) {
        self.email = email
    }
    
    func setOccupation(_ occupation: String) {
        self.occupation = occupation
    }
    
    
    func getName() -> String {
        return self.name
    }
    
    func getGender() -> String {
        return self.gender
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getOccupation() -> String {
        return self.occupation
    }
    
   
}
