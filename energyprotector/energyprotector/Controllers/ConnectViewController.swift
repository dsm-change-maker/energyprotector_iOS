//
//  ConnectViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/09.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit
import Alamofire

let baseURL = "https://energyprotector.run.goorm.io"
var token : String = ""

class ConnectViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var groupNameTextField: UITextField!
    @IBOutlet var idTextField: UITextField!
    @IBOutlet var pwdTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let groupName = UserDefaults.standard.string(forKey: "groupName"){
            if let Id = UserDefaults.standard.string(forKey: "id"){
                groupNameTextField.text = groupName
                idTextField.text = Id
            }
        }

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
        if groupNameTextField.text == ""{
            alert("그룹 이름을 확인해주세요!")
        }
        else if idTextField.text == ""{
            alert("아이디를 확인해주세요!")
        }
        else if pwdTextField.text == ""{
            alert("비밀번호를 확인해주세요!")
        }
        else{
            
            let parameters: [String: String] = [
                "raspberry_group": groupNameTextField.text!,
                "raspberry_id": idTextField.text!,
                "raspberry_pw": pwdTextField.text!
            ]
            
            let alamo = AF.request(baseURL+"/api/web/login", method: .post, parameters:parameters, encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300)
            
            alamo.responseJSON(){ response in
                switch response.result
                {
                    //통신성공
                    case .success(let value):
                        
                        let valueNew = value as? [String:Any]
                        token = valueNew?["access_token"] as! String
                        
                        UserDefaults.standard.set(self.groupNameTextField.text, forKey: "groupName")
                        UserDefaults.standard.set(self.idTextField.text, forKey: "id")
                        UserDefaults.standard.set(self.pwdTextField.text, forKey: "pwd")
                        self.goMain()
                        
                    //통신실패
                    case .failure( _):
                        self.alert("정보가 일치하지 않습니다.")
                }
            }


        }
    }
    
    func alert(_ phrases : String) {
            let alert = UIAlertController(title: phrases, message: nil, preferredStyle: .alert)
            let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(okButton)
            self.present(alert,animated: true, completion: nil)
        }
    
    func goMain() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        vcName?.modalTransitionStyle = .coverVertical
        vcName?.modalPresentationStyle = .fullScreen
        self.present(vcName!, animated: true, completion: nil)
    }
    
    
}

