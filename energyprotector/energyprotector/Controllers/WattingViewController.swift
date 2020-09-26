//
//  WattingViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/17.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit
import Alamofire

class WattingViewController: UIViewController {
    
    override func viewDidAppear(_ animated: Bool) {
        if let groupName = UserDefaults.standard.string(forKey: "groupName"){
            if let id = UserDefaults.standard.string(forKey: "id"){
                if let pwd = UserDefaults.standard.string(forKey: "pwd"){
                    let parameters: [String: String] = [
                        "raspberry_group": groupName,
                        "raspberry_id": id,
                        "raspberry_pw": pwd
                    ]
                    
                    let alamo = AF.request(baseURL+"/api/web/login", method: .post, parameters:parameters, encoder: JSONParameterEncoder.default).validate(statusCode: 200..<300)
                    
                    alamo.responseJSON(){ response in
                        switch response.result
                            {
                            //통신성공
                            case .success(let value):
                                let valueNew = value as? [String:Any]
                                token = valueNew?["access_token"] as! String
                                self.goMain()
                            //통신실패
                            case .failure( _):
                                self.goLogin()
                            }
                    }
                }else{
                    goLogin()
                }
            }else{
                goLogin()
            }
        }else{
            goLogin()
        }
    }
        
    func goLogin() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "loginVC")
        vcName?.modalTransitionStyle = .coverVertical
        vcName?.modalPresentationStyle = .fullScreen
        self.present(vcName!, animated: true, completion: nil)
    }
    
    func goMain() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "mainVC")
        vcName?.modalTransitionStyle = .coverVertical
        vcName?.modalPresentationStyle = .fullScreen
        self.present(vcName!, animated: true, completion: nil)
    }
        

}
