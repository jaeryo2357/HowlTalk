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
    
    let cellIndeifier : String = "toDoCell"
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
        if( textField.isEqual(self.textField))
        {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIndeifier, for: indexPath)
        cell.textLabel?.text = toDoList[indexPath.row]
        return cell
      }
      
    @IBAction func pushViewNext(){
        if let vc = storyboard?.instantiateViewController(identifier: "second"){
            self.title = ""
            self.navigationController?.pushViewController(vc, animated: true)
      }
    }

}

