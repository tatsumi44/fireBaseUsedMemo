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
    var array:[[String : Any]]!
    
    //cellの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        cell?.textLabel?.text = "テスト"
        return cell!
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        db = Firestore.firestore()
        db.collection("main").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    //                    self.array?.append(document.data())
                    print("\(document.documentID) => \(document.data())")
                    
                }
            }
        }
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
