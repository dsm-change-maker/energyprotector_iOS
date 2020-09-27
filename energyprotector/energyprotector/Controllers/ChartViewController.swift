//
//  ChartViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/16.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit
import Charts
import Alamofire

class ChartViewController: UIViewController, ChartViewDelegate {
    
    let months = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width,
                                height: self.view.frame.size.width)
        barChart.center = view.center
        view.addSubview(barChart)
        
        var entries1 = [BarChartDataEntry]()

        for x in 0..<12 {
            entries1.append(BarChartDataEntry(x: Double(x),
                                             y: Double(x*x*x))
            )
        }
        
        
        let set1 = BarChartDataSet(entries: entries1, label: "에너지 사용량")
        set1.setColor(UIColor(displayP3Red: 40/250, green: 39/250, blue: 76/250, alpha: 1))
        
        let data = BarChartData()
        
        barChart.data = data
    }
    
    func getData() {
        if let groupName = UserDefaults.standard.string(forKey: "groupName"){
            if let id = UserDefaults.standard.string(forKey: "id"){
                let parameters: [String: Any] = [
                    "raspberry_group": groupName,
                    "raspberry_id": id,
                    "year": false,
                    "month": true,
                    "month_n": 12,
                    "day": false
                ]
        
                AF.request(baseURL+"/api/web/using-time", method: .get, parameters:parameters).validate().responseJSON(completionHandler: { res in
            
                    switch res.result {
                    case .success(let value):
                        print(value)
                        let valueNew = value as? [String:Any]
                        if let data = valueNew?["mon"] as? [[String: Any]]{
                            
                        }
                    case .failure(let err):
                        print("ERROR : \(err)")
                    }
                })
            }
        }
    }

}


