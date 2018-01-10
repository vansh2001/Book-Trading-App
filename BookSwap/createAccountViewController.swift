//
//  createAccountViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 7/16/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

// Firebase Storage
let storReference = FIRStorage.storage().reference()

//Firebase Database Reference
let dataReference = FIRDatabase.database().reference()

class createAccountViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var toLogin: UIButton!
    @IBOutlet weak var labelCreateAccount: UILabel!
    @IBOutlet weak var registerEmail: UITextField!
    @IBOutlet weak var registerPassword: UITextField!
    @IBOutlet weak var registerRePassword: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBAction func registerUser(sender: AnyObject) {
        
        if (registerEmail.text == "" || registerPassword.text == "" || registerRePassword.text == "") {
            
            let alert = UIAlertController(title: "Unsuccessful", message: "All feilds are required", preferredStyle: UIAlertControllerStyle.Alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        // if passwords don't match perform error
        if (registerPassword.text != registerRePassword.text) {
            
            let alert = UIAlertController(title: "Unsuccesfull", message: "Passwords don't match", preferredStyle: UIAlertControllerStyle.Alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "Try Again", style: UIAlertActionStyle.Default, handler: nil))
            // show the alert
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        
        // Register User
        FIRAuth.auth()?.createUserWithEmail(registerEmail.text!, password: registerRePassword.text!) { (user, error) in
            ///error in registration
            
                if error != nil{
                    
                    let alert = UIAlertController(title: "Unsuccessful", message: "Make sure all fields are entered correctly", preferredStyle: UIAlertControllerStyle.Alert)
                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                    // show the alert
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                }
                    
                else {
                    
                    //Store Profile Image
                    //user pic compressed 80%
                    if let uploadData = UIImageJPEGRepresentation(self.profileImage.image!, 0.8) {
                        storReference.child("UserProfileImages").child(user!.uid).putData(uploadData ,metadata: nil, completion: { (metadata, error) in
                            
                            if error != nil{
                                print("profile upload error")
                                
                                return
                            }else {
                                print(metadata)
                        
                    let downloadURL = metadata!.downloadURL
                    let user = dataReference.child("user").child(user!.uid)
                                let values = ["name": self.name.text!, "username": self.username.text!, "email": self.registerEmail.text!, "profileImage": downloadURL()!.absoluteString]
                                
                                user.updateChildValues(values, withCompletionBlock: { (err, dataReference) in
                        
                        
                        if err != nil {
                        
                        print("error in database")
                        return
                        
                        }
                        
                        print("Saved user succesfully")
                    })
                                    
                    print("User data Saved into Firebase db")
                    // move to Login
                    self.performSegueWithIdentifier("LoginView", sender: nil)
                            }
                        })
                    }

            }
        }
    }
    
    //Chosing an Image from CameraRoll
///////////////////////////////////////
    
    // Gesture to Profile ImageView controller with gesture tapped to select photo
    @IBAction func handleImageTapped(sender: UITapGestureRecognizer) {
        
        let actionSheetController: UIAlertController = UIAlertController(title: "Action Sheet", message: "Choose an option!", preferredStyle: .ActionSheet)
        
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

    
    
////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        profileImage.layer.cornerRadius = profileImage.frame.size.width/2
        profileImage.clipsToBounds = true
    }
    //override func viewDidAppear(animated: Bool) {
        //super.viewDidAppear(animated)
    
        
    //}
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
