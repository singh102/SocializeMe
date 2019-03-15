//
//  ApplicationState.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/13/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation

class ApplicationState {
    static let instance = ApplicationState()
    
    var name: String
    var users: [String]

    
    
    
    init() {
        self.name = ""
        self.users = []
    }
    
 
    
    func print() {
        Swift.print("\(name) \n ")
    }
    
    
    
}
