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
 
//if you use delegate
//Model, view를 구별할수 있는 기능 Custom Model class 추가 해도 됨
//    var model : String?
//    weak var delegate : CustomTableViewCellDelegate?
//
    var deleteButtonAction : (()->())?
    var checkButtonAction : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.deleteButton.addTarget(self, action: #selector(deleteCellTapped(_:)), for: .touchUpInside)
        self.checkButton.addTarget(self, action: #selector(checkCellTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func deleteCellTapped(_ sender: UIButton){
// if you use delegate
//        if let model = model,
//           let delegate = delegate{
//            delegate.CustomTableViewCell(_cell: self, deleteCellTappedFor: model)
//        }
        deleteButtonAction?()
    }
    
    @IBAction func checkCellTapped(_ sender: UIButton){
        if(!sender.isSelected){
            let stroke = CALayer()
            stroke.frame = CGRect(x: 0, y: workLabel.frame.size.height / 2, width: workLabel.frame.width, height: 1)
            stroke.backgroundColor = UIColor.gray.cgColor
            workLabel.layer.addSublayer(stroke)
            workLabel.textColor = UIColor.gray
        }else{
            workLabel.layer.sublayers?.removeAll()
           workLabel.textColor = UIColor.black
        }
        sender.isSelected = !sender.isSelected
        
        checkButtonAction?()
    }
}

//if you use delegate
//protocol CustomTableViewCellDelegate : AnyObject{
//     func CustomTableViewCell(_cell : CustomTableViewCell,deleteCellTappedFor model : String?)
//}
