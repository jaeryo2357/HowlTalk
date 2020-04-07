//
//  ViewController.swift
//  ToDo
//
//  Created by YangMinUk on 19/03/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate
        ,UITextFieldDelegate{
  
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
        return cell
      }
      
    @IBAction func pushViewNext(){
        if let vc = storyboard?.instantiateViewController(identifier: "second"){
            self.title = ""
            self.navigationController?.pushViewController(vc, animated: true)
      }
    }

}

