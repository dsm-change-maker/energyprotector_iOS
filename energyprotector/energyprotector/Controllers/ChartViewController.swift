//
//  ChartViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/16.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit
import Charts

class ChartViewController: UIViewController, ChartViewDelegate {
    
    var barChart = BarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        var entries2 = [BarChartDataEntry]()

        for x in 0..<12 {
            entries1.append(BarChartDataEntry(x: Double(x),
                                             y: Double(x*x*x))
            )
            entries2.append(BarChartDataEntry(x: Double(x),
                                             y: Double(1000))
            )
        }
        
        
        let set1 = BarChartDataSet(entries: entries1, label: "에너지 사용량")
        let set2 = BarChartDataSet(entries: entries2, label: "평균")
        set1.setColor(UIColor(displayP3Red: 40/250, green: 39/250, blue: 76/250, alpha: 1))
        set2.setColor(UIColor.lightGray)
        
        let data = BarChartData(dataSets: [set2,set1])
        
        barChart.data = data
    }

}


