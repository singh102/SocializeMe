//
//  ErrorEngine.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/3/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class AlertEngine {
    static func createIncorrectPasswordAlert() -> UIAlertController {
        return createAlert("Incorrect Username or Password Given")
    }
    
    static func createAlert(_ message: String) -> UIAlertController {
        let alertController = UIAlertController(title: "\(message)",
                                                       message: nil,
                                                       preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Okay", style: .default))
        
        return alertController
    }
}
