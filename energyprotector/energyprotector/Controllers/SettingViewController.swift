//
//  SettingViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/16.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet weak var deviceIdLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        deviceIdLable.text = UserDefaults.standard.string(forKey: "id")
    }

    @IBAction func saveBtn(_ sender: Any) {
    }
    @IBAction func disconnectionBtn(_ sender: Any) {
        let alert = UIAlertController(title: "연결해제 하시겠습니까?", message: nil, preferredStyle: .alert)
                let cancelButton = UIAlertAction(title: "취소", style: .default, handler: nil)
                let okButton = UIAlertAction(title: "연결해제", style: .default, handler: { action in
                    UserDefaults.standard.removeObject(forKey: "groupName")
                    UserDefaults.standard.removeObject(forKey: "id")
                    UserDefaults.standard.removeObject(forKey: "pw")
                    self.goWatting()
                })
                alert.addAction(cancelButton)
                alert.addAction(okButton)
                self.present(alert,animated: true, completion: nil)
    }
    
    func goWatting() {
        let vcName = self.storyboard?.instantiateViewController(withIdentifier: "wattingVC")
        vcName?.modalTransitionStyle = .coverVertical
        vcName?.modalPresentationStyle = .fullScreen
        self.present(vcName!, animated: true, completion: nil)
    }
    
}
