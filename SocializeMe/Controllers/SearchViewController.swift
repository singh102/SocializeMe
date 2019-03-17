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
import FirebaseStorage

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    
    
    @IBOutlet weak var contactsTable: UITableView!
    @IBOutlet weak var contactSearch: UISearchBar!
    
    var image: UIImage?
    
    let applicationState: ApplicationState = ApplicationState.instance
    var databaseReference: DatabaseReference!
    var storageRef: StorageReference!
    
    var usersFromSearch = [String]()
    var usersFromDb = [String]()
    var friendsFromDb = [String]()
   
    // view controller specific methods
    override func viewDidLoad() {
        databaseReference = Database.database().reference()
        storageRef = Storage.storage().reference()
        
      
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setUpContacts()
        self.loadFriends()
        super.viewWillAppear(animated)
    }
    
    // search bar specific functions
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.contactSearch.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
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
 
    // Set up table view
    
    private func setUpContacts() {
        let name = self.applicationState.name
        if name.count > 0 {
            let usersRef = databaseReference.child("profiles")
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
        return usersFromDb.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = contactsTable.dequeueReusableCell(withIdentifier: "contact") as? ContactCell {
            cell.contactName.text = usersFromDb[indexPath.row]
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userNameSelected = usersFromSearch[indexPath.row]
        print(userNameSelected)
        
        if self.friendsFromDb.contains(userNameSelected) {
            self.present(AlertEngine.createAlert("\(userNameSelected) already a friend"),
                         animated: true,
                         completion: nil)
        } else {
            let alertController =
                UIAlertController(title: "\(userNameSelected)",
                    message: "message",
                    preferredStyle: .alert)
            alertController.addAction(self.createAddUserAction(userNameSelected))
            alertController.addAction(UIAlertAction(title: "Cancel",
                style: .cancel,
                handler: nil))
            self.present(alertController,
                         animated: true,
                         completion: nil)
        }
 
    }
    
    func loadFriends() {
        let userNameRef = databaseReference.child("friends").child(self.applicationState.name)
        userNameRef.observe(.value, with: { (snapshot: DataSnapshot) in
            let user = snapshot.value as? [String: String]
            
            if let actualUser = user {
                self.friendsFromDb = Array(actualUser.values)
            }
        })
        
    }
    
    func createAddUserAction(_ userName: String) -> UIAlertAction {
        let addAction =
            UIAlertAction(title: "Add \(userName)",
            style: .default) { _ in
                let confirmAlertController = UIAlertController(title: "Added \(userName)",
                    message: nil,
                    preferredStyle: .alert)
                confirmAlertController.addAction(UIAlertAction(title: "Confirm", style: .default, handler: {action in self.someHandler(userName)}))
                self.present(confirmAlertController,
                             animated: true,
                             completion: nil)
        }
        
        return addAction
    }
    
    
    func someHandler(_ userName: String) {
        
        databaseReference.child("friends").child(self.applicationState.name).childByAutoId().setValue(userName)
    }
    
    
}
