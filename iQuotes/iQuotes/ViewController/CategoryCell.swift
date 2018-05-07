//
//  CategoryCell.swift
//  iQuotes
//
//  Created by Alumnos on 5/5/18.
//  Copyright © 2018 Alumnos. All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    
    @IBOutlet weak var categoryNameLabel: UILabel!
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    func updateValue(from category: Category) {
//        if let name = category.name {
//
//        }
        categoryNameLabel.text = category.name
    }
}
