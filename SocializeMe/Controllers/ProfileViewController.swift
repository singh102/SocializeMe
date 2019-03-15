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
    var dbRef: DatabaseReference!
    
    var postContent: String = ""
    
    let applicationState: ApplicationState = ApplicationState.instance
    
    var userPosts: [String?] = []
    
    override func viewDidLoad() {
        self.retrieveProfileDataForUserName(self.applicationState.name)
        self.postsTableView.dataSource = self
        self.postsTableView.delegate = self
        self.postsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "basic")
        
        storageRef = Storage.storage().reference()
        dbRef = Database.database().reference()
        
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let postsRef = dbRef.child("posts").child("akadiyala")
        postsRef.observeSingleEvent(of: .value, with: { (snapshot: DataSnapshot) in
            
//            if let postsSnapShot = snapshot.value as? [String] {
//                print(postsSnapShot)
//                //self.userPosts = postsSnapShot
//            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
 
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = userPosts[indexPath.row - 1]
        let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = post
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userPosts.count
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
