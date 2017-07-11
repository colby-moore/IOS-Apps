//
//  ViewController.swift
//  messageApp
//
//  Created by Colby Moore on 7/9/17.
//  Copyright © 2017 Colby Moore. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var nameTextField: UITextField!
   
    @IBAction func action(_ sender: Any) {
        if emailTextField.text != "" && passTextField.text != "" {
            if segmentControl.selectedSegmentIndex == 0 { //login user
                Auth.auth().signIn(withEmail: emailTextField.text!, password: passTextField.text!) { (user, error) in
                    if user != nil{
                        
                        // User authentication successful
                        
                        self.performSegue(withIdentifier:"loginSegue", sender: self)
                    }
                    else{
                        if let myError = error?.localizedDescription{
                            print(myError)
                        }
                        else{
                            print("Error")
                        }
                    }
                }
            }
            else { // Sign up user
                Auth.auth().createUser(withEmail: emailTextField.text!, password: passTextField.text!) { (user, error) in
                    if user != nil{
                        
                        guard let uid = user?.uid else{
                            return
                        }
                        
                        var ref: DatabaseReference!
                        ref = Database.database().reference()
                        let usersReference = ref.child("users").child(uid)
                        let values = ["name": self.nameTextField.text, "email": self.emailTextField.text]
                        usersReference.updateChildValues(values, withCompletionBlock: { (err, ref) in
                            
                            if err != nil{
                                print(err)
                                return
                            }
                            print("save user successfully into firebase db")
                            
                        })

                        
                        self.performSegue(withIdentifier:"loginSegue", sender: self)
                    }
                    else{
                        if let myError = error?.localizedDescription{
                            print(myError)
                        }
                        else{
                            print("Error")
                        }
                    }
                }
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

