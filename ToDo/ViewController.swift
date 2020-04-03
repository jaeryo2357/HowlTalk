//
//  ViewController.swift
//  ToDo
//
//  Created by YangMinUk on 19/03/2020.
//  Copyright © 2020 MinUkYang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func pushViewNext(){
        if let vc = storyboard?.instantiateViewController(identifier: "second"){
            self.title = ""
            self.navigationController?.pushViewController(vc, animated: true)
      }
    }

}

