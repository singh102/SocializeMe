//
//  ProfileCreationViewController.swift
//  SocializeMe
//
//  Created by Karthik Singh on 3/13/19.
//  Copyright © 2019 Karthik Singh. All rights reserved.
//

import UIKit
import Foundation
import FirebaseDatabase
import FirebaseStorage

class ProfileCreationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtGender: UITextField!
    @IBOutlet weak var txtOccupation: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imageProfile: UIImageView!
    
    var dbRef: DatabaseReference!
    var storageRef: StorageReference!
    let applicationState: ApplicationState = ApplicationState.instance

    override func viewDidLoad() {
        super.viewDidLoad()
        
        dbRef = Database.database().reference();
        storageRef = Storage.storage().reference();
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning();
    }
    
    @IBAction func doneEditing(_ sender: UITextField) {
        sender.resignFirstResponder();
    }
    
    @IBAction func save(_ sender: UIButton) {
        var newProfileDictionary: [String: String] = [:];
        
        if let fullName = txtFullName.text {
            newProfileDictionary["name"] = fullName;
        }
        
        if let email = txtEmail.text {
            newProfileDictionary["email"] = email;
        }
        
        if let gender = txtGender.text {
            newProfileDictionary["gender"] = gender;
        }
        
        if let occupation = txtOccupation.text {
            newProfileDictionary["occupation"] = occupation;
        }
        
        if let description = txtDescription.text {
            newProfileDictionary["description"] = description;
        }
        
        if let userName = txtUserName.text {
            
            if let image = imageProfile.image {
                if let imageData = image.jpegData(compressionQuality: 0.7) {
                    let reference = self.storageRef.child("profileimages/\(userName).jpg");

                    let uploadMetaData = StorageMetadata();
                    uploadMetaData.contentType = "image/jpeg";

                    reference.putData(imageData, metadata: uploadMetaData) { (metadata, error) in
                        if let error = error {
                            print(error);
                            return;
                        }
                    }
                }
            }
            
            self.dbRef.child("profiles")
                .child(userName)
                .setValue(newProfileDictionary);
            
            if let password = txtPassword.text {
                self.dbRef.child("Users")
                    .child(userName)
                    .setValue(["password": password]);
            }
            
            self.applicationState.name = userName
        }
    }
    
    /** Image **/
    @IBAction func addProfileImage(_ sender: UIButton) {
        let picker = UIImagePickerController();
        picker.delegate = self;
        present(picker, animated: true, completion: nil);
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[.originalImage] as? UIImage {
            imageProfile.image = originalImage;
        }

        dismiss(animated: true, completion: nil);
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil);
    }
}
