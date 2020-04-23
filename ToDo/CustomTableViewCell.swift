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
    
    //Model, view를 구별할수 있는 기능 Custom Model class 추가 해도 됨
    var model : String?
    weak var delegate : CustomTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.deleteButton.addTarget(self, action: #selector(deleteCellTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func deleteCellTapped(_ sender: UIButton){
        if let model = model,
           let delegate = delegate{
            delegate.CustomTableViewCell(_cell: self, deleteCellTappedFor: model)
        }
    }
}

protocol CustomTableViewCellDelegate : AnyObject{
     func CustomTableViewCell(_cell : CustomTableViewCell,deleteCellTappedFor model : String?)
}
