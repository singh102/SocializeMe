//
//  ProfileViewController.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 2/28/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {
    
    var userInfo: UserInfoProfile?
    var importantThing: String = "Name"
    
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var genderTextField: UILabel!
    @IBOutlet weak var occupationTextField: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("Here in profile view")
        print(importantThing)//        userNameText.text = userInfo.getName()
//        email.text! = userInfo.getEmail()
//        genderTextField.text! = userInfo.getGender()
//        occupationTextField.text! = userInfo.getOccupation()
//

        
    }
    
}
