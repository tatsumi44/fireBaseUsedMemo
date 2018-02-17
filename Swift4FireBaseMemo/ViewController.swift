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
        //データベースからデータを取得し、表示
        if mainArray.isEmpty == false{
            mainArray = [[String : Any]]()
            idArray = [String]()
            cellOfNum = nil
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
                    print(self.mainArray)
                }
            }
            print("存在するよ")
            
        }else{
            db = Firestore.firestore()
            db.collection("main").getDocuments() { (querySnapshot, err) in
                if let err = err {
                    print("Error getting documents: \(err)")
                } else {
                    for document in querySnapshot!.documents {
                        self.idArray.append(document.documentID)
                        self.mainArray.append(document.data())
                        //                        print("\(document.documentID) => \(document.data())")
                    }
                    self.table.reloadData()
                    
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
        //画面遷移
        performSegue(withIdentifier: "Register", sender: nil)
    }
    //RegisterViewControllerに値を渡す
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
        if mainArray.isEmpty == false{
            titles = mainArray[indexPath.row]["title"] as! String
            cell?.textLabel?.text = titles
        }else{
            print("何もないよ")
        }
        return cell!
    }
    //cellの数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if mainArray.isEmpty == false{
            return mainArray.count
        }else{
            print("cellの数")
            return 0
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //スワイプして削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            contentsId = idArray[indexPath.row]
            db.collection("main").document(contentsId).delete() { err in
                if let err = err {
                    print("Error removing document: \(err)")
                } else {
                    print("Document successfully removed!")
                    self.mainArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
            
        }
    }
    //新規登録
    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "Register", sender: nil)
    }
    
}

