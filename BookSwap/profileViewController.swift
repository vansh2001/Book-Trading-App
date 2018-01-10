//
//  profileViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 7/16/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class profileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate {

// Initializers
    //return to sidebar
    
    
    @IBAction func returnSidebar(sender: AnyObject) {
    }
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var displayUser: UILabel!
    @IBOutlet weak var displayEmail: UILabel!
    @IBOutlet weak var profileImage: UIImageView!
    @IBAction func deleteAccount(sender: AnyObject) {
        
        // Create the alert controller
        let alertController = UIAlertController(title: "Title", message: "Message", preferredStyle: .Alert)
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) {
            UIAlertAction in
            NSLog("OK Pressed")
            self.proceedwithAccountDelete()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")
        }
        
        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
        
            }
    
    func proceedwithAccountDelete () {
        // Account deleted.
        dataReference.child("user").child(self.userID).removeValueWithCompletionBlock({ (er, dataReference) in
            if er != nil {
                print("user deletion error in database")
            }
            else {
                print("user deleted")
            }
        })
        
        storReference.child("UserProfileImages").child(self.userID).deleteWithCompletion { (error) in
            if error != nil {
                print("\(error)")
            } else {
                
                print("user profile pic successfully deleted")
                let user = FIRAuth.auth()?.currentUser
                user?.deleteWithCompletion { error in
                    if error != nil {
                        
                        //error
                        print("Account deletion error")
                    } else {
                        //Success
                        print("account deleted")
                        
                        // Present Login Page
                        self.performSegueWithIdentifier("LoginPage", sender: self)
                    }
                    
                }
            }
        }
    }

    //User Firebase ID
    let userID:  String = (FIRAuth.auth()?.currentUser?.uid)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.profileImage.layer.cornerRadius = self.profileImage.frame.size.width/2
        self.profileImage.clipsToBounds = true
        
        
        //Capturing data from users current ID
        dataReference.child("user").child(userID).observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            
            let Email = snapshot.value!["email"] as! String
            let Username = snapshot.value!["username"] as! String
            let Name = snapshot.value!["name"] as! String
            
            
            // Attach to Outlets
            self.displayName.text = Name
            self.displayUser.text = Username
            self.displayEmail.text = Email
 
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
    // Profile update with a popover
    @IBAction func profileUpdate(sender: AnyObject) {
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
