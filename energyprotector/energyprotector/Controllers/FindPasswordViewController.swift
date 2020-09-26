//
//  FindPasswordViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/21.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit

class FindPasswordViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func callBtn(_ sender: Any) {
        if let phoneCallUrl = URL(string: "tel://01084339169") {
                    let application:UIApplication = UIApplication.shared
                        
                    if (application.canOpenURL(phoneCallUrl)){
                        application.open(phoneCallUrl, options: [:], completionHandler: nil)
                    }
                }
    }
    
}
