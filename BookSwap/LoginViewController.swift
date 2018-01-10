//
//  LoginViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 7/15/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBAction func createAccount(sender: AnyObject) {
        
    }
@IBAction func userLogin(sender: AnyObject) {
    
    
    FIRAuth.auth()?.signInWithEmail(Username.text!, password: Password.text!) { (user, error) in

        if error != nil {
            
            let alert = UIAlertController(title: "Sign in unsuccessful", message: "Credentials don't match", preferredStyle: UIAlertControllerStyle.Alert)
             //add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            //show the alert
            self.presentViewController(alert, animated: true, completion: nil)
        
            } else {
        print("User signed in")
            self.performSegueWithIdentifier("mainpage", sender: nil)
            
        }
        
      }
    
    }
        

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        if FIRAuth.auth()?.currentUser?.uid == nil{
            handleLogout()
            
        } else {
            print("logoutError")
        }
    }
    
        func handleLogout() {
            do {
            try! FIRAuth.auth()?.signOut()
                
            } catch let logoutError {
                print(logoutError)
            }
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

