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
    
    var db : ToDoDB?
    let cellIndeifier : String = "customCell"
    var toDoList : [ToDoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView?.delegate = self
        self.tableView?.dataSource = self
        textField?.delegate = self
        textField?.returnKeyType = .join
        
        do{
          db = try ToDoDB()
        } catch ToDoDB.SQLError.connectionError{
            print("not open DB")
        } catch {
            print("some Error")
        }
        
        if let myDB = db {
            toDoList = myDB.fetchToDo()
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if( textField.isEqual(self.textField)){
            let toDoInput = self.textField?.text
            if let value = toDoInput ,let myDB = db {
              let id = myDB.insertToDo(work: value)
              let item = ToDoItem(id: id, working: value, isSelected: false)
              toDoList.append(item)
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
        cell.workLabel.text = toDoList[indexPath.row].working
        cell.checkButton.isSelected = toDoList[indexPath.row].isSelected
        cell.workLabel.sizeToFit()
// if you use tag property
//        //assign the indexRow to button tag
//        cell.deleteButton.tag = indexPath.row
//        //call the deleteCell method when tapped
//        cell.deleteButton.addTarget(self, action: #selector(deleteCell(_:)), for: .touchUpInside)
        
 //if you use delegate
//        cell.model = toDoList[indexPath.row]
//        cell.delegate = self
        
        cell.deleteButtonAction = {
            let indexRow = indexPath.row
           
            if let myDB = self.db{
                myDB.deleteToDo(id: self.toDoList[indexRow].id)
            }
            self.toDoList.remove(at: indexRow)
            self.tableView?.reloadData()
        }
        
        cell.checkButtonAction = {
            self.toDoList[indexPath.row].isSelected = cell.checkButton.isSelected
        }
        return cell
    }
    
//    func CustomTableViewCell(_cell: CustomTableViewCell, deleteCellTappedFor model: String?) {
//        let indexPath = toDoList.firstIndex(of: model!)
//        toDoList.remove(at: indexPath!)
//        tableView?.reloadData()
//       }

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

