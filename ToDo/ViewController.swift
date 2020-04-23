//
//  ViewController.swift
//  ToDo
//
//  Created by YangMinUk on 19/03/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
,UITextFieldDelegate,CustomTableViewCellDelegate{
   

    @IBOutlet var tableView : UITableView?
    @IBOutlet var textField : UITextField?
    
    let cellIndeifier : String = "customCell"
    var toDoList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        textField?.delegate = self
        textField?.returnKeyType = .join
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if( textField.isEqual(self.textField)){
            let toDoInput = self.textField?.text
            if let value = toDoInput {
              toDoList.append(value)
              self.textField?.text = ""
              tableView?.reloadData()
            }
        }
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
      }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell : CustomTableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIndeifier, for: indexPath) as? CustomTableViewCell else {
            preconditionFailure("테이블 뷰 셀 가져오기 실패")
        }
        cell.workLabel.text = toDoList[indexPath.row]
//        //assign the indexRow to button tag
//        cell.deleteButton.tag = indexPath.row
//        //call the deleteCell method when tapped
//        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        cell.model = toDoList[indexPath.row]
        cell.delegate = self
        return cell
    }
    
    func CustomTableViewCell(_cell: CustomTableViewCell, deleteCellTappedFor model: String?) {
        let indexPath = toDoList.firstIndex(of: model!)
        toDoList.remove(at: indexPath!)
        tableView?.reloadData()
       }

//    @objc func deleteCell(_ sender: UIButton){
//        let indexRow = sender.tag
//        toDoList.remove(at: indexRow)
//        tableView?.reloadData()
//    }
//
    @IBAction func pushViewNext(){
        if let vc = storyboard?.instantiateViewController(identifier: "second"){
            self.title = ""
            self.navigationController?.pushViewController(vc, animated: true)
      }
    }

}

