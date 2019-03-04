//
//  ErrorEngine.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/3/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class ErrorEngine {
    static func createIncorrectPasswordAlert() -> UIAlertController {
        return createErrorAlert("Incorrect Username or Password Given")
    }
    
    static func createErrorAlert(_ message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "\(message)",
                                                       message: nil,
                                                       preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        
        return alertController
    }
    
    
}
