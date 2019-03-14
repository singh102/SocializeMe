//
//  UserInfoProfile.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/1/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation

class ApplicationState {
    static let instance = ApplicationState()
  
    var name: String

    
    init() {
        self.name = ""
    }
   
    init(_ name: String) {
        self.name = name
    }
    
    func print() {
        Swift.print("\(name) \n ")
    }
    
//    func isValidUser() -> Bool {
//        return self.name.count > 0
//    }
}
