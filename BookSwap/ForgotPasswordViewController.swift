
//  ForgotPasswordViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 7/21/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var resetPasswordEmail: UITextField!
    @IBAction func resetPasswordButtonPressed(sender: AnyObject) {
        
        let email = resetPasswordEmail.text
        
        FIRAuth.auth()?.sendPasswordResetWithEmail(email!) { error in
            
            if error != nil {
                // An error happened.
                print("Email does not match")
                let alert = UIAlertController(title: "Error", message: "Email does not match. Please try again.", preferredStyle: UIAlertControllerStyle.Alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                // show the alert
                self.presentViewController(alert, animated: true, completion: nil)

            } else {
                // Password reset email sent.
                print("Email sent to reset")
                let alert = UIAlertController(title: "Successful", message: "Check your email to reset your password.", preferredStyle: UIAlertControllerStyle.Alert)
                // add an action (button)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
                // show the alert
                //self.presentViewController(alert, animated: true, completion: nil)

            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
