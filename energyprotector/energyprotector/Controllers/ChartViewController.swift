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
        
        var entries = [BarChartDataEntry]()

        for x in 0..<12 {
            entries.append(BarChartDataEntry(x: Double(x),
                                             y: Double(x*x*x))
            )
        }
        
        let set = BarChartDataSet(entries: entries, label: "에너지 사용량")
        set.colors = ChartColorTemplates.joyful()
        
        let data = BarChartData(dataSet: set)
        
        barChart.data = data
    }

}


