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

        deviceIdLable.text = "1wefwowe12"
    }

    @IBAction func saveBtn(_ sender: Any) {
    }
    @IBAction func disconnectionBtn(_ sender: Any) {
    }
}
