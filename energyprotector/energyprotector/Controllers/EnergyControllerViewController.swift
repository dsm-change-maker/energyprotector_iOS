//
//  EnergyControllerViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/15.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit
import Alamofire

class EnergyControllerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    var switchArr : [String] = []
    var devices = [device]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getData()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func getData() {
        
        AF.request(baseURL+"/api/web/devices", method: .get, parameters: [:],headers: ["authorization": "Bearer "+token]).validate().responseJSON(completionHandler: { res1 in
            
            switch res1.result {
                case .success(let value):
                    print(value)
                    let valueNew = value as? [String:Any]
                    if let data = valueNew?["devices"] as? [[String: Any]]{
                        for dataIndex in data {
                            self.devices.append(device(device_id: dataIndex["device_id"] as! String,
                                                  device_type: dataIndex["device_type"] as! String,
                                                  unit_count: dataIndex["unit_count"] as! Int))
                        }
                        
                        for device in self.devices {
                            AF.request(baseURL+"/api/web/units", method: .get, parameters: ["device_id":device.device_id,"device_type":device.device_type],headers: ["authorization": "Bearer "+token]).validate().responseJSON(completionHandler: { res2 in
                                
                                switch res2.result {
                                case .success(let value):
                                    print(value)
//                                    let valueNew = value as? [String:Any]
//                                    if let data = valueNew?["devices"] as? [[String: Any]]{
//                                    }
//
//                                    self.tableView.reloadData()
                                case .failure(let err):
                                    print("ERROR : \(err)")
                                    
                                }
                            })
                        }
                        
                        self.tableView.reloadData()
                    }
                case .failure(let err):
                    print("ERROR : \(err)")
                }
        })
        
    }
    
    @objc func switchChanged(_ sender: UISwitch!){
        
        print("change: \(sender.tag + 1)")
        print("the switch is \(sender.isOn ? "ON" : "OFF")")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        cell.textLabel?.text = devices[indexPath.section].device_type + " " + String(indexPath.row)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        
        let switchView = UISwitch(frame: .zero)
        switchView.onTintColor = UIColor(red: 71/250, green: 70/250, blue: 102/250, alpha: 1)
        switchView.setOn(false, animated: true)
        switchView.tag = indexPath.row
        switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        
        cell.accessoryView = switchView
        
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return devices.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return devices[section].unit_count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.0
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return devices[section].device_id
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = UIColor(red: 40/250, green: 39/250, blue: 76/250, alpha: 1)
            headerView.textLabel?.textColor = .white
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}

struct device {
    let device_id : String
    let device_type : String
    let unit_count : Int
} 
