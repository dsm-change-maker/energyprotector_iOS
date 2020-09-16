//
//  EnergyControllerViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/15.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit

class EnergyControllerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var switchArr : [String] = []
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        for x in 1...5{
            switchArr.append("스위치\(x)")
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return switchArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = switchArr[indexPath.row]
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        
        let switchView = UISwitch(frame: .zero)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        cell.accessoryView = switchView
        
        return cell
    }
    
    @objc func switchChanged(_ sender: UISwitch!){
        
        print("change: \(sender.tag + 1)")
        print("the switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
