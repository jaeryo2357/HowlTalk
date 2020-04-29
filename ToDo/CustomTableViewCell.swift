//
//  CustomTableViewCell.swift
//  ToDo
//
//  Created by YangMinUk on 07/04/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell ,UITextFieldDelegate{

    @IBOutlet var workLabel : UITextField!
    @IBOutlet var checkButton : UIButton!
    @IBOutlet var deleteButton : UIButton!
    @IBOutlet var updateButton : UIButton!
 
//if you use delegate
//Model, view를 구별할수 있는 기능 Custom Model class 추가 해도 됨
//    var model : String?
//    weak var delegate : CustomTableViewCellDelegate?
//
    var deleteButtonAction : (()->())?
    var checkButtonAction : (()->())?
    var updateButtonAction : ((String)->())?
    
    var textTemp : String? = ""
    let stroke = CALayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        workLabel.delegate = self
        workLabel.sizeToFit()
    }
    
    func settingStroke(){
        stroke.frame = CGRect(x: 0, y: workLabel.frame.size.height / 2, width: workLabel.frame.width, height: 1)
               stroke.backgroundColor = UIColor.gray.cgColor
               
       if checkButton.isSelected {
         workLabel.layer.addSublayer(stroke)
       }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        self.deleteButton.addTarget(self, action: #selector(deleteCellTapped(_:)), for: .touchUpInside)
        self.checkButton.addTarget(self, action: #selector(checkCellTapped(_:)), for: .touchUpInside)
        self.updateButton.addTarget(self, action: #selector(updateCellTapped(_:)), for: .touchUpInside)
    }
    
    @IBAction func deleteCellTapped(_ sender: UIButton){
// if you use delegate
//        if let model = model,
//           let delegate = delegate{
//            delegate.CustomTableViewCell(_cell: self, deleteCellTappedFor: model)
//        }
        deleteButtonAction?()
    }
    
    @IBAction func updateCellTapped(_ sender : UIButton){
       
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected { //수정모드
            textTemp = workLabel.text
            workLabel.isEnabled = true
            workLabel.becomeFirstResponder()
        }else{
            workLabel.text = textTemp
            workLabel.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           if( textField.isEqual(self.workLabel)){ //textField가 return 받을 때
            self.updateButton.isSelected = false
            self.workLabel.isEnabled = false
            if let text = self.workLabel.text{
                settingStroke()
                updateButtonAction?(text)
            }
           }
           return true
       }
    
    @IBAction func checkCellTapped(_ sender: UIButton){
        if(!sender.isSelected){
            workLabel.layer.addSublayer(stroke)
            workLabel.textColor = UIColor.gray
        }else{
            workLabel.layer.sublayers?.removeLast()
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
