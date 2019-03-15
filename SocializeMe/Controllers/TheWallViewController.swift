//
//  TheWallViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 3/14/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import FirebaseDatabase

class TheWallViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var txtPost: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    var dbRef: DatabaseReference!
    
    var posts = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self;
        tableView.dataSource = self;
        
        dbRef = Database.database().reference();
        
        dbRef.child("posts").child("test").observe(.childAdded, with: { (snapshot) in
            let post = snapshot.value as? String
            if let actualPost = post {
                self.posts.append(actualPost)
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row];
        let cell = tableView.dequeueReusableCell(withIdentifier: "post", for: indexPath);
        
        // Configure the cell...
        cell.textLabel?.text = post;
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count;
    }
    
    @IBAction func uploadPost(_ sender: UIButton) {
        if let post = txtPost.text {
            // Need to get current user
            dbRef.child("posts").child("test").childByAutoId().setValue(post)
        }
    }
}
