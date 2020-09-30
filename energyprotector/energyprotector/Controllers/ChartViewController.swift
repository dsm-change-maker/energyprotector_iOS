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
    
    var barChart = BarChartView()
    
    var entries1 = [BarChartDataEntry]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        barChart.frame = CGRect(x: 0, y: 0,
                                width: self.view.frame.size.width - 20,
                                height: self.view.frame.size.width)
        barChart.center = view.center
        barChart.xAxis.labelPosition = XAxis.LabelPosition.bottom
        barChart.rightAxis.enabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.xAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawGridLinesEnabled = false
        barChart.rightAxis.drawAxisLineEnabled = false
        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.leftAxis.drawAxisLineEnabled = false
        barChart.xAxis.labelCount = 12
        barChart.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
        view.addSubview(barChart)
        
    }
    
    func setChart() {
        
        let formato:BarChartFormatter = BarChartFormatter()
        let xaxis:XAxis = XAxis()
        
        

        for _ in 0..<12 {
            xaxis.valueFormatter = formato
            barChart.xAxis.valueFormatter = xaxis.valueFormatter
        }
        
        
        let set1 = BarChartDataSet(entries: entries1, label: "에너지 사용량")
        set1.setColor(UIColor(displayP3Red: 40/250, green: 39/250, blue: 76/250, alpha: 1))
        
        let data = BarChartData(dataSets: [set1])
        
        barChart.data = data
        
        
    }
    
    func getData() {
        if let groupName = UserDefaults.standard.string(forKey: "groupName"){
            if let id = UserDefaults.standard.string(forKey: "id"){
                let parameters: [String: Any] = [
                    "raspberry_group": groupName,
                    "raspberry_id": id
                ]
        
                AF.request(baseURL+"/api/web/using-time/"+thisYear()+"?"+now(), method: .get,  parameters:parameters).validate().responseJSON(completionHandler: { res in
            
                    switch res.result {
                    case .success(let value):
                        print(value)
                        let valueNew = value as? [String:Any]
                        if let data = valueNew?["using_time"] as? [[String: Any]]{
                            
                            var i = 1
                            
                            for dataIndex in data {
                                
                                self.entries1.append(BarChartDataEntry(x: Double(i-1),
                                                                 y: Double(dataIndex[
                                                                            self.thisYear()+"-"+String(format: "%02d", i)] as! Int)/3600)
                                
                                )
                                i += 1
                            }
                        }
                        self.setChart()
                    case .failure(let err):
                        print("ERROR : \(err)")
                    }
                })
            }
        }
    }
    
    func thisYear() -> String{
        let formatter_year = DateFormatter()
        formatter_year.dateFormat = "yyyy"
        let current_year_string = formatter_year.string(from: Date())
        return current_year_string
    }
    
    func now() -> String{
        let formatter_time = DateFormatter()
        formatter_time.dateFormat = "ss"
        let current_time_string = formatter_time.string(from: Date())
        return current_time_string
    }
    
    @objc(BarChartFormatter)
    public class BarChartFormatter: NSObject, IAxisValueFormatter
    {
      var months: [String]! = ["1월", "2월", "3월", "4월", "5월", "6월", "7월", "8월", "9월", "10월", "11월", "12월"]

        public func stringForValue(_ value: Double, axis: AxisBase?) -> String
      {
        return months[Int(value)]
      }
    }

}


