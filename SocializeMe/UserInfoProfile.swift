//
//  UserInfoProfile.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/1/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation

class UserInfoProfile {
    
    var email: String
    var gender: String
    var name: String
    var occupation: String
    var posts: [String]
    
    init() {
        self.email = ""
        self.gender = ""
        self.name = ""
        self.occupation = ""
        self.posts = []
    }
    
    init(_ name: String, _ gender: String, _ email: String, _ occupation: String, _ posts: [String]) {
        self.name = name
        self.gender = gender
        self.email = email
        self.occupation = occupation
        self.posts = posts
    }
    
    func print() {
        Swift.print("\(name) \n \(gender) \n \(email) \n \(occupation)")
    }
    
    func addPost(_ post: String) {
        self.posts.append(post)
    }
    
    func isValidUser() -> Bool {
        return self.name.count > 0 && self.email.count > 0 && self.gender.count > 0 && self.occupation.count > 0
    }
}
