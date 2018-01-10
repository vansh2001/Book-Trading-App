//
//  SideBarViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 7/21/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class SideBarViewController: UIViewController {

@IBAction func userLogout(sender: AnyObject) {
        
        ///Logout and return to Login Page
        try! FIRAuth.auth()!.signOut()
        
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
