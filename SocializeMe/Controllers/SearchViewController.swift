//
//  SearchViewController.swift
//  SocializeMe
//
//  Created by Abhiram Kadiyala on 3/14/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
   
    @IBOutlet weak var contactsTable: UITableView!
    @IBOutlet weak var contactSearch: UISearchBar!
    
    let applicationState: ApplicationState = ApplicationState.instance
    
    var posts = [Contact]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpContacts()
    }
    
    private func setUpContacts() {
        let name = self.applicationState.name
        if name.count > 0 {
            let usersRef = Database.database().reference().child("Users")
            usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                
                print(snap)
                let userData = snap as! [String]
                print(userData)
                
                
            
            }) { (err: Error) in
                print("\(err.localizedDescription)")
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contactsTable.dequeueReusableCell(withIdentifier: "contact") as? ContactCell else {
            return UITableViewCell()
        }
        
        cell.contactName.text = posts[indexPath.row].name
        
        return cell
        

        
    }
    
}

class Contact {
    var name: String
    
    init(_ name: String) {
        self.name = name
    }
}
