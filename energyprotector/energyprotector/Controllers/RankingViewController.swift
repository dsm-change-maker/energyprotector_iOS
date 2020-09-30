//
//  RankingViewController.swift
//  energyprotector
//
//  Created by 김수완 on 2020/09/30.
//  Copyright © 2020 김수완. All rights reserved.
//

import UIKit
import Alamofire

class RankingViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var deviceIdLable: UILabel!
    @IBOutlet weak var myRankingLable: UILabel!
    @IBOutlet weak var solutionLable: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    var myRank : Int = 0
    var total : Int = 0
    
    var ranking = [rank]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let groupName = UserDefaults.standard.string(forKey: "groupName"){
            if let Id = UserDefaults.standard.string(forKey: "id"){
                deviceIdLable.text = groupName+" "+Id
            }
        }
        
        getMyRank()
        getRanking()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.allowsSelection = false
    }
    
    func getMyRank() {
        
        AF.request( baseURL+"/api/web/myranking?"+now(), method: .get,parameters: [:] ,headers: ["authorization": "Bearer "+token]).validate().responseJSON(completionHandler: { res in
            
            switch res.result {
                case .success(let value):
                    print(value)
                    let valueNew = value as? [String:Any]
                    self.myRank = valueNew?["rank"] as? Int ?? 0
                    self.total = valueNew?["total"] as? Int ?? 0
                    self.myRankingLable.text = String(self.myRank)
                    
                    if self.myRank == 1 {
                        self.solutionLable.text = "1등 달성!!!"
                    }
                    else if self.myRank < (self.total/5) {
                        self.solutionLable.text = "잘하고있어요!"
                    }
                    else if self.myRank < (self.total/3) {
                        self.solutionLable.text = "조금만 더 힘내세요!"
                    }
                    else if self.myRank < (self.total/3)*2 {
                        self.solutionLable.text = "더 노력해야겠어요!"
                    }
                    else{
                        self.solutionLable.text = "노력이 부족하네요..."
                    }
                    
                case .failure(let err):
                    print("ERROR : \(err)")
                }
        })
        
    }
    
    func getRanking() {
        
        AF.request( baseURL+"/api/web/ranking?"+now(), method: .get,parameters: [:] ,headers: [:]).validate().responseJSON(completionHandler: { res in
            
            switch res.result {
                case .success(let value):
                    print(value)
                    let valueNew = value as? [String:Any]
                    if let data = valueNew?["ranking"] as? [[String: Any]]{
                        for dataIndex in data {
                            self.ranking.append(rank(grop: dataIndex["raspberry_group"] as! String,
                                                     id: dataIndex["raspberry_id"] as! String))
                        }
                    }
                    self.tableView.reloadData()
                    
                case .failure(let err):
                    print("ERROR : \(err)")
                }
        })
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ranking.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RankCell
        cell.number.text = String(indexPath.row + 1)
        cell.name.text = ranking[indexPath.row].grop + " " + ranking[indexPath.row].id
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
    func now() -> String{
        let formatter_time = DateFormatter()
        formatter_time.dateFormat = "ss"
        let current_time_string = formatter_time.string(from: Date())
        return current_time_string
    }

}

struct rank {
    let grop : String
    let id : String
}


class RankCell: UITableViewCell {
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var name: UILabel!
}
