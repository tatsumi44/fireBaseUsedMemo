//
//  ViewController.swift
//  Swift4FireBaseMemo
//
//  Created by tatsumi kentaro on 2018/02/16.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var db: Firestore!
    var mainArray = [[String : Any]]()
    var titles:String!
    
    
    //cellの内容
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        db = Firestore.firestore()
        db.collection("main").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    
//                    print(document.data())
                    self.mainArray.append(document.data())
//                    print(self)
                     print(String(describing: type(of: document.data())))
                    
//                    self.mainArray.append(self.array)
//                    print("\(document.documentID) => \(document.data())")
                    
                }
//                print(self.mainArray)
                print(self.mainArray[0]["title"] as! String)
//                print(String(describing: type(of: self.mainArray[0]["title"])))
            }
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        print("へい")
    }
    override func viewDidDisappear(_ animated: Bool) {
        print("へいへい")
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        titles = mainArray[indexPath.row]["title"] as! String
        print(titles)
        cell?.textLabel?.text = titles
        return cell!
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(mainArray.count)
        return mainArray.count
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: nil)
    }
    @IBAction func comfirmButton(_ sender: Any) {
        
        
    }
}
