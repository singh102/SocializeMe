//
//  TheWallViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 3/14/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TheWallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    @IBOutlet weak var txtPost: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var dbRef: DatabaseReference!
    
    
    var posts = [Post]()
    var friendUserNames = [String]()
    
    let applicationState: ApplicationState = ApplicationState.instance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        txtPost.delegate = self;
        
        dbRef = Database.database().reference();
        
        dbRef.child("friends").child(self.applicationState.name).observe(.childAdded, with: { (snapshot) in
            let friendNameOptional = snapshot.value as? String
            if let friendName = friendNameOptional {
                self.dbRef.child("profiles").observeSingleEvent(of: .value, with: { (snapshot) in
                    for child in snapshot.children {
                        if let profile = child as? DataSnapshot {
                            if let profileValue = profile.value {
                                let profileData = profileValue as! [String:String]
                                if (profileData["name"] == friendName) {
                                    self.friendUserNames.append(profile.key)
                                    self.dbRef.child("posts").child(profile.key).observe(.childAdded, with: { (snapshot) in
                                        let post = snapshot.value as? String
                                        if let actualPost = post {
                                            let post = Post(actualPost, friendName)
                                            self.posts.append(post)
                                            self.tableView.reloadData()
                                        }
                                    })
                                }
                            }
                        }
                    }
                })
            }
        })

        self.dbRef.child("posts").child(self.applicationState.name).observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post {
                self.posts.append(Post(actualPost, self.applicationState.name))
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath) as! WallContentCell
        
        cell.postContent.text = post.postContent
        cell.name.text = post.name
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            self.txtPost.resignFirstResponder()
            return false
        }
        
        return true
    }
    
    @IBAction func uploadPost(_ sender: UIButton) {
        if let post = txtPost.text {
            dbRef.child("posts").child(applicationState.name).childByAutoId().setValue(post)
        }
    }
}

class Post {
    var postContent: String
    var name: String
    
    init() {
        self.postContent = ""
        self.name = ""
    }
    
    init(_ postContent: String, _ name: String) {
        self.postContent = postContent
        self.name = name
    }
    
}
