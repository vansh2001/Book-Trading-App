//
//  BooksViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/14/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

let FirebaseUserID:  String = (FIRAuth.auth()?.currentUser?.uid)!

class BooksViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    
      var dataPassed = String()

    @IBOutlet weak var UniversityName: UITextField!
    @IBOutlet weak var itemBookPic: UIImageView!
    @IBOutlet weak var price: UITextField!
    @IBOutlet weak var ISBN: UITextField!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Author: UITextField!
    @IBAction func upload(sender: AnyObject) {
        
        //Store Book Image
        //user pic compressed 80%
        if let uploadData = UIImageJPEGRepresentation(self.itemBookPic.image!, 0.8) {
            
            storReference.child("Item_books").child(FirebaseUserID).child(self.Name.text!).putData(uploadData ,metadata: nil, completion: { (metadata, error) in
                
                if error != nil{
                    print("profile upload error")
                    
                    return
                }else {
                    print(metadata)
                    
                    let downloadURL = metadata!.downloadURL
                     let user = dataReference.child("Items").child("Books").childByAutoId()
                    let values = ["name": self.Name.text!, "ISBN": self.ISBN.text!, "Author": self.Author.text!, "price": self.price.text!, "book pic URL": downloadURL()!.absoluteString, "University": self.UniversityName.text!]
                    
                    user.updateChildValues(values, withCompletionBlock { (err, dataReference) in
                        
                        
                        if err != nil {
                            
                            print("error in book upload")
                            return
                            
                        }
                        
                        print("Saved item- book succesfully")
                    })
                    
                    print("item data Saved into Firebase db")
                    // move to Login
                    
                }

            })
        }

    }
      
      
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //University Name data passed
        UniversityName.text = dataPassed
        

        // Do any additional setup after loading the view.
    }
    
    // Gesture to Profile ImageView controller with gesture tapped to select photo
    @IBAction func chooseBookPicure(sender: AnyObject) {

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
        
        self.itemBookPic.image = newImage
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
