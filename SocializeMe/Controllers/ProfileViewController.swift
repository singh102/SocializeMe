//
//  ProfileViewController.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 2/28/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import FirebaseStorage

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var userNameText: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var genderTextField: UILabel!
    @IBOutlet weak var occupationTextField: UILabel!
    @IBOutlet weak var postsTableView: UITableView!
    
    var storageRef: StorageReference!
    
    var postContent: String = ""
    
    let applicationState: ApplicationState = ApplicationState.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.retrieveProfileDataForUserName(self.applicationState.name)
        self.retrievePostsForUserName(self.applicationState.name)
        self.postsTableView.dataSource = self
        self.postsTableView.delegate = self
        self.postsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "basic")
        
        storageRef = Storage.storage().reference()
    }
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        if postContent.count > 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
            
            // Configure the cell
            let formatter = DateFormatter()
            formatter.dateFormat = "dd.MM.yyyy"
            let result = formatter.string(from: Date())
            
            cell.textLabel?.text = "\(result) - \(postContent)"
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func retrievePostsForUserName(_ userName: String) {
        if userName.count > 0 {
            let usersRef = Database.database().reference().child("posts/\(userName)")
            usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                
                if let snapVal = snap.value as? String {
                    print(snapVal)
                }
              
                
            
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
        }
    }
    
    
    func retrieveProfileDataForUserName(_ userName: String) {
    
        if userName.count > 0 {
            let usersRef = Database.database().reference().child("profiles/\(userName)")
            usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                
                let userInfoDict = snap.value as! [String: String]
                let name: String = userInfoDict["name"] ?? ""
                let gender = userInfoDict["gender"] ?? ""
                let occupation = userInfoDict["occupation"] ?? ""
                let email = userInfoDict["email"] ?? ""
            
                
                self.userNameText.text = name
                self.genderTextField.text = gender
                self.email.text = email
                self.occupationTextField.text = occupation
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
        }
    }
    
}
