//
//  Books.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/15/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import Foundation
import UIKit
import Firebase

struct BooksStructure {
    
    var name: String!
    var price: String!
    var author: String!
    var isbn: String!
    var itemImage: String!
    var universityName: String!
    
    init (name: String, price: String, author: String, isbn: String, itemImage: String, universityName: String)
    {

        self.name = name
        self.price = price
        self.author = author
        self.isbn  = isbn
        self.itemImage = itemImage
        self.universityName = universityName
        
    }

}

