//
//  ItemBooksTableViewController.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/15/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit
import Firebase

class ItemBooksTableViewController: UITableViewController{

    var books = [BooksStructure]()
    
    
       
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
// Load from database
        dataReference.child("Items").child("Books").queryOrderedByKey().observeEventType(.ChildAdded , withBlock: { (snapshot) in
    
            
            let Author = snapshot.value!["Author"] as! String
            let ISBN = snapshot.value!["ISBN"] as! String
            let Name = snapshot.value!["name"] as! String
            let Price = snapshot.value!["price"] as! String
            let PicURL = snapshot.value!["book pic URL"] as! String
            let UniversityName = snapshot.value!["University"] as! String
            print(snapshot)
            
            self.books.insert(BooksStructure(name: Name, price: Price, author: Author, isbn: ISBN, itemImage: PicURL, universityName: UniversityName), atIndex: 0)
            self.tableView.reloadData()


        
            
    })
}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ItemBooksTableViewCell
        
        
        
        let book = books[indexPath.row]
        
        cell.itemName.text = book.name
        cell.itemPrice.text = book.price
        cell.itemAuthor.text = book.author
        cell.itemISBN.text = book.isbn
        cell.universityName.text = book.universityName
        
        //Getting Image from URL
        if let itemImageURL = book.itemImage {
            let url = NSURL(string: itemImageURL)
            NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: {( data, response , error) in
            
            //download error
            if error != nil {
                print("item pic error")
                return
            }
                
                dispatch_async(dispatch_get_main_queue(), {
                    //Load into the Tabel View as Image
            cell.itemImage.image = UIImage(data:  data!)
                    
            //Rounded Images
            //cell.itemImage?.layer.cornerRadius = (cell.itemImage?.frame.size.width)! / 2
            //cell.itemImage?.layer.masksToBounds = true
                    
                })
        }).resume()
        }
        
        return cell
    }

}




