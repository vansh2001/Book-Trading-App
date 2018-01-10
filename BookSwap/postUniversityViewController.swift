//
//  postViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/6/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class postUniversityViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var pickerUniversity: UIPickerView!
    @IBAction func Next(sender: AnyObject) {
    }
    //Class created in Model: UniversityNames
    var UniversityData = ["Select a University","Duke University","NCSTATE University","UNC at Chapel Hill","UNC at Charlotte","UNC at Greensboro","UNC at Pembroke","UNC at Wilmington","UNC School of the Arts"]
    
    var Universityvalue = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return UniversityData[row]
    }
        
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return UniversityData.count
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
   }
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Universityvalue = UniversityData[row]
        print(Universityvalue)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "toCategoryController") {
            let svc = segue.destinationViewController as! CategoryViewController
            svc.dataPassed = Universityvalue

        }
    }
}
