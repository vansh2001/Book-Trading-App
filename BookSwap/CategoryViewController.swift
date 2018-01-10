//
//  CategoryViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/8/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class CategoryViewController: UIViewController, UIPickerViewDelegate {

    @IBOutlet weak var UniversityChoosen: UILabel!
    
    var dataPassed = String()
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        UniversityChoosen.text = dataPassed
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "CategoryToBooks") {
            let svc = segue.destinationViewController as! BooksViewController
            svc.dataPassed = dataPassed
            
        }
    }


    
}
