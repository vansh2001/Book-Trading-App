//
//  ItemBooksTableViewCell.swift
//  BookSwap
//
//  Created by Harivansh Mareddy on 8/15/16.
//  Copyright © 2016 Harivansh Mareddy. All rights reserved.
//

import UIKit

class ItemBooksTableViewCell: UITableViewCell {

    @IBOutlet weak var itemName: UILabel!
    @IBOutlet weak var itemPrice: UILabel!
    @IBOutlet weak var itemAuthor: UILabel!
    @IBOutlet weak var itemISBN: UILabel!
    @IBOutlet weak var itemImage: UIImageView!
    @IBOutlet weak var universityName: UILabel!
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
