//
//  ApplicationState.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/13/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class ApplicationState {
    static let instance = ApplicationState()
    
    var name: String
    var users: [String]
    var profileImage: UIImage
    var isUserCreation: Bool
    
    init() {
        self.name = ""
        self.users = []
        self.profileImage = UIImage()
        self.isUserCreation = false;
    }
    
 
    
    func print() {
        Swift.print("\(name) \n ")
    }
    
    
    
}
