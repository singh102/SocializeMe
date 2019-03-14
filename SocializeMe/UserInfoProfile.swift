//
//  UserInfoProfile.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/13/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation

class UserInfoProfile {
    var name: String
    var email: String
    var occupation: String
    var gender: String
    
    init() {
        self.name = ""
        self.email = ""
        self.gender = ""
        self.occupation = ""
    }
    
    init(_ name: String, _ email: String, _ gender: String, _ occupation: String) {
        self.name = name
        self.email = email
        self.gender = gender
        self.occupation = occupation
    }
    
    func print() {
        Swift.print("\(name) \n \(gender) \n \(email) \n \(occupation)")
    }
}
