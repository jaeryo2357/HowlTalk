//
//  SecondViewController.swift
//  ToDo
//
//  Created by YangMinUk on 23/03/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController ,UITableViewDelegate,
UITableViewDataSource{

    @IBOutlet var tableView : UITableView?
    
    let cellIdentifier :String = "cell"
    let korean : [String] = ["가","나","다","라"]
    let english : [String] = ["A","B","C","D"]
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           switch section {
           case 0:
               return korean.count
           case 1:
               return english.count
           default:
               return 0
           }
    }
      
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
           return section == 0 ? "한글" : "영어"
       }
       
       
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
           let cell : UITableViewCell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
           
           let title : String = indexPath.section == 0 ? korean[indexPath.row] : english[indexPath.row]
           cell.textLabel?.text = title
           return cell
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Settings"
        // Do any additional setup after loading the view.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
