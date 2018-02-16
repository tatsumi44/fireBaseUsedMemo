//
//  RegisterViewController.swift
//  Swift4FireBaseMemo
//
//  Created by tatsumi kentaro on 2018/02/16.
//  Copyright © 2018年 tatsumi kentaro. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var contentsTextField: UITextView!
    
    var db : Firestore!
    var mainTitle: String!
    var contents: String!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentsTextField.layer.borderColor =  UIColor.black.cgColor
        contentsTextField.layer.borderWidth = 1.0
//        FirebaseApp.configure()
        db = Firestore.firestore()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        addAdaLovelace()
       
    }
    private func addAdaLovelace() {
        // [START add_ada_lovelace]
        // Add a new document with a generated ID
        var ref: DocumentReference? = nil
        mainTitle = titleTextField.text
        contents = contentsTextField.text
        ref = db.collection("main").addDocument(data: [
            "title":String(mainTitle),
            "contents":String(contents),
            "Date": Date()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }

        // [END add_ada_lovelace]
    }
    
}
