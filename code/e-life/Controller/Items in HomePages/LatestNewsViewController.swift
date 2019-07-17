//
//  LatestNewsViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CustomCell6 : UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var newsText: UILabel!
}

class LatestNewsViewController: UIViewController {

    var newsArray : [JSON] = []
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Activity/findAll"

    @IBOutlet var tableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var community = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        community = appDelegate.community
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    // Mark: - Fetch data from server
    func fetchData() {
        AF.request(URL, method: .post, parameters: ["community": community]).responseJSON { (response) in
            if let json = response.value{
                let latestNewsArray = JSON(json).arrayValue
                self.newsArray = latestNewsArray
                self.tableView.reloadData()
                //activitiesArray =
            }
        }
        
    }
    
}

extension LatestNewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell6
        
        cell.title.text = newsArray[indexPath.row]["title"].stringValue
        cell.newsText.text = newsArray[indexPath.row]["detail"].stringValue
        return cell
    }
}
