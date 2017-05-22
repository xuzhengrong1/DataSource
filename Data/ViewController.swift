//
//  ViewController.swift
//  Data
//
//  Created by 许正荣 on 2017/5/22.
//  Copyright © 2017年 许正荣. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var dataSource : GeneralDataSource<UITableViewCell, Person>?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let p1 =   Person();
        p1.name = "11";
        let p2 =   Person();
        p2.name = "22";
        let p3 =   Person();
        p3.name = "33";

//        self.tableView.register(UITableViewCell.class, forCellReuseIdentifier: "Cell")
      
        dataSource =   GeneralDataSource.init(items: [[p1,p2,p3]], cellReuseIdentifier: "Cell") { (cell:UITableViewCell, p) in
            cell.textLabel?.text =  p.name
        }
        self.tableView.dataSource = dataSource
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
       
    }
    
    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 3;
//    }
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//         let cell = tableView.dequeueReusableCell(withIdentifier: "Cell");
//        cell?.textLabel?.text = "11"
//        return cell!
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

