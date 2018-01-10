//
//  ProfileUpdateViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/13/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class ProfileUpdateViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameUpdate: UITextField!
    @IBOutlet weak var usernameUpdate: UITextField!
    @IBOutlet weak var emailUpdate: UITextField!
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func saveProfile(sender: AnyObject) {
        
        user?.updateEmail(self.emailUpdate.text!) { error in
            if let error = error {
                print("user email update error")
            } else {
                print("Email updated")
                
                if let uploadData = UIImageJPEGRepresentation(self.profileImage.image!, 0.8) {
                    storReference.child("UserProfileImages").child(self.user!.uid).putData(uploadData ,metadata: nil, completion: { (metadata, error) in
                        
                        if error != nil{
                            print("profile upload error")
                            
                            return
                        }else {
                            print(metadata)
                            
                            let downloadURL = metadata!.downloadURL
                            let user = dataReference.child("user").child(self.user!.uid)
                            let values = ["name": self.nameUpdate.text!, "username": self.usernameUpdate.text!, "email": self.emailUpdate.text!, "profileImage": downloadURL()!.absoluteString]
                            user.updateChildValues(values, withCompletionBlock: { (err, dataReference) in
                                
                                
                                if err != nil {
                                    
                                    print("error in database")
                                    return
                                    
                                }
                                
                                print("Saved user succesfully")
                            })
                            
                            print("User data Saved into Firebase db")
                            // move to Login
                            self.performSegueWithIdentifier("toProfile", sender: nil)
                        }
                    })

        
//        let users = dataReference.child("user").child(self.userID)
//        let values = ["name": self.nameUpdate.text!, "username": self.usernameUpdate.text!, "email": self.emailUpdate.text!]
//        users.updateChildValues(values, withCompletionBlock: { (err, dataReference) in
//            
//            
//            if err != nil {
//                
//                print("error updating users data")
//                return
//                
//            } else {
//            
//            print("User data Updated")
                    }
        
               // })
                //self.performSegueWithIdentifier("toProfile", sender: self)
            }
        }
    }
    // Choose profile pic
    @IBAction func changeProfilePic(sender: AnyObject) {
        self.pickuserProfile()
      }
    
    // Current User
    let user = FIRAuth.auth()?.currentUser

    // User Email
    let userEmail = FIRAuth.auth()?.currentUser?.email
    
    //User ID
    let userID:  String = (FIRAuth.auth()?.currentUser?.uid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true


        // Do any additional setup after loading the view.
        
       
        //Capturing data from users current ID
        dataReference.child("user").child(userID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            let Username = snapshot.value!["username"] as! String
            let Name = snapshot.value!["name"] as! String
            
            
            // Attach to Outlets
            self.nameUpdate.text = Name
            self.usernameUpdate.text = Username
            self.emailUpdate.text = self.userEmail
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            storReference.child("UserProfileImages").child(self.userID).dataWithMaxSize(2 * 1024 * 1024) { (data, error) -> Void in
                if (error != nil) {
                    // Uh-oh, an error occurred!
                    print("Profile Load error")
                    
                } else {
                    // Data for "images/island.jpg" is returned
                    //self.profileImage.image! = UIImage(data: data!)!
                    
                    if let ProfileImage = UIImage(data: data!) {
                        self.profileImage.image = ProfileImage
                    }
                }
            }
            
        })
        
    }
    
    //Pick Users Profile Photo
    
    //Chosing an Image from CameraRoll
    ///////////////////////////////////////
    func pickuserProfile(){
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Profile Picture", message: "Choose an option!", preferredStyle: .ActionSheet)
        
        //Create and add the Cancel action
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel) { action -> Void in
            //Just dismiss the action sheet
        }
        actionSheetController.addAction(cancelAction)
        //Create and add first option action
        let takePictureAction: UIAlertAction = UIAlertAction(title: "Take Picture", style: .Default) { action -> Void in
            //Code for launching the camera goes here
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = .Camera
            self.presentViewController(picker, animated: true, completion: nil)
        }
        actionSheetController.addAction(takePictureAction)
        //Create and add a second option action
        let choosePictureAction: UIAlertAction = UIAlertAction(title: "Choose From Camera Roll", style: .Default) { action -> Void in
            //Code for picking from camera roll goes here
            let picker = UIImagePickerController()
            picker.allowsEditing = true
            picker.delegate = self
            picker.sourceType = .PhotoLibrary
            self.presentViewController(picker, animated: true, completion: nil)
        }
        actionSheetController.addAction(choosePictureAction)
        
        //Present the AlertController
        self.presentViewController(actionSheetController, animated: true, completion: nil)
    }
    
    //imagepicker canceled
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
            
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        }else {
            return
        }
        
        self.profileImage.image = newImage
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
