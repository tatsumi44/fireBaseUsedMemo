//
//  ViewController.swift
//  Swift4FireBaseMemo
//
//  Created by tatsumi kentaro on 2018/02/16.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    
    @IBOutlet weak var table: UITableView!
    var db: Firestore!
    var mainArray = [[String : Any]]()
    var titles:String!
    var idArray = [String]()
    var cellOfNum:Int!
    var cellOfArray = [String: Any]()
    var contentsId: String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.dataSource = self
        table.delegate = self
       
    }
    override func viewDidAppear(_ animated: Bool) {
        if mainArray != nil{
            mainArray = [[String : Any]]()
            idArray = [String]()
            db = Firestore.firestore()
            db.collection("main").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.idArray.append(document.documentID)
                        self.mainArray.append(document.data())
                        print("\(document.documentID) => \(document.data())")
                    }
                    self.table.reloadData()
                    print(self.idArray)
                    print(self.mainArray[0])
                }
            }
            
        }else{
            db = Firestore.firestore()
            db.collection("main").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.idArray.append(document.documentID)
                        self.mainArray.append(document.data())
                        print("\(document.documentID) => \(document.data())")
                    }
                    self.table.reloadData()
                    print(self.idArray)
                    print(self.mainArray[0])
                }
            }
            print("へい")
        }
    }
    
    //セルをクリックした時に呼ばれる
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellOfArray = mainArray[indexPath.row]
        contentsId = idArray[indexPath.row]
        cellOfNum = indexPath.row
        print(cellOfArray)
        print(contentsId)
        performSegue(withIdentifier: "Register", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Register"{
            let registerViewContoroller = segue.destination as! RegisterViewController
            registerViewContoroller.cellOfNum = self.cellOfNum
            registerViewContoroller.cellOfArray = self.cellOfArray
            registerViewContoroller.contentsId = self.contentsId
        }
        
    }
    //cellの内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")
        titles = mainArray[indexPath.row]["title"] as! String
        print("cellの内容")
        cell?.textLabel?.text = titles
        return cell!
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("cellの数")
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

