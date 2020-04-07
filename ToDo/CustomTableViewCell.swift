//
//  CustomTableViewCell.swift
//  ToDo
//
//  Created by YangMinUk on 07/04/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    @IBOutlet var workLabel : UILabel!
    @IBOutlet var checkButton : UIButton!
    @IBOutlet var deleteButton : UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
