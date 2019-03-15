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

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
   
    @IBOutlet weak var contactsTable: UITableView!
    @IBOutlet weak var contactSearch: UISearchBar!
    
    let applicationState: ApplicationState = ApplicationState.instance
    
    var usersFromSearch = [String]()
    var usersFromDb = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.setUpContacts()
        super.viewWillAppear(animated)
    }
    
    // Search Bar
    private func setUpSearchBar() {
    
        
    }
 
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            usersFromSearch = usersFromDb;
            self.contactsTable.reloadData()
            return
            
        }
        usersFromSearch = usersFromDb.filter({ user -> Bool in
            if let searchText = searchBar.text {
                return user.lowercased().hasPrefix(searchText.lowercased())
            } else {
                return false
            }
            
        })
        
        self.contactsTable.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    
    // Set up table view
    
    private func setUpContacts() {
        
    
        let name = self.applicationState.name
        if name.count > 0 {
            let usersRef = Database.database().reference().child("profiles")
            usersRef.observeSingleEvent(of: .value, with: {(snap : DataSnapshot) in
                
                var usersFromDb: [String] = []
             
                for child in snap.children {
                    if let userNameSnap = child as? DataSnapshot{
                        if let value = userNameSnap.value {
                            let userData = value as! [String: String]
                            let name: String = userData["name"] ?? ""
                        
                            usersFromDb.append(name)
                            
                            
                        }
                    }
                  
                    
                }
                
                self.usersFromDb = usersFromDb
                self.usersFromSearch = usersFromDb
                self.contactsTable.reloadData()
         
            }) { (err: Error) in
                print("\(err.localizedDescription)")
                
            }
         
        }
     
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersFromSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = contactsTable.dequeueReusableCell(withIdentifier: "contact") as? ContactCell else {
            return UITableViewCell()
        }
        
        cell.contactName.text = usersFromSearch[indexPath.row]
        return cell
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        
    }
    
}

