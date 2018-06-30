//
//  CustomSubCell.swift
//  IntCoreTask
//
//  Created by Admin on 6/29/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class CustomSubCell: UITableViewCell {

    @IBOutlet weak var comment: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
