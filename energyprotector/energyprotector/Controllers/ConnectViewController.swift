//
//  ConnectViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/09.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit

class ConnectViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        groupNameTextField.delegate = self
        idTextField.delegate = self
        pwdTextField.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
          view.endEditing(true)
      }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    @IBAction func loginBtn(_ sender: Any) {
        
    }
    
}
