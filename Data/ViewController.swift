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
        let arr = [p1,p2,p3];
        let filterArr =  arr.ndElement { (p) -> Bool in
            p.name == "11"
        }
        let arr2 = [1,2,3];
//        arr2.map2(transform: <#T##(Int) -> U#>)

//        self.tableView.register(UITableViewCell.class, forCellReuseIdentifier: "Cell")
      
        dataSource =   GeneralDataSource.init(items: [[p1,p2,p3]], cellReuseIdentifier: "Cell") { (cell:UITableViewCell, p) in
            cell.textLabel?.text =  p.name
        }
        self.tableView.dataSource = dataSource
//        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            
            let p5 =   Person();
            p5.name = "11";
            self.dataSource?.items.append([p5]);
            self.tableView.reloadData()
        };
       
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


extension Array {
    func map2<U>(transform: @escaping (Element) -> U) -> [U] {
        return reduce([]) {
            $0 + [transform($1)]
        } }
    func  lter2 (includeElement: (Element) -> Bool) -> [Element] { return reduce([]) {
        includeElement($1) ? $0 + [$1] : $0 }
    } }


extension Array {
    func reduce<U>(initial: U, combine: (U, Element) -> U) -> U {
        var result = initial; for e in self {result = combine(result,e)
        }
        return result
    }
}

extension Sequence {
    func  ndElement (match: (Iterator.Element)->Bool) -> Iterator.Element? {
        for element in self where match(element) { return element
        }
        return nil
    }
}

extension Array {
    func accumulate<U>(initial: U, combine: (U, Element) -> U) -> [U] {
        var running = initial
        return self.map { next in
            running = combine(running, next)
            return running }
    } }

extension UIViewController{
    open  override static func initialize()
    {
//        methodSwizThreadSafe(self, #selector(UIViewController.viewWillAppear(_:)), #selector(UIViewController.xl_viewWillAppear(animated:)))
        
         methodSwizThreadSafe(self, #selector(UIViewController.viewDidLoad), #selector(UIViewController.xl_viewDidLoad))
    }
    
    func xl_viewWillAppear(animated: Bool) {
        self.xl_viewWillAppear(animated: animated)
        print("xl_viewWillAppear in swizzleMethod")
    }
    

    func xl_viewDidLoad() {
        self.xl_viewDidLoad()
        print("xl_viewDidLoad in swizzleMethod")
    }
}

