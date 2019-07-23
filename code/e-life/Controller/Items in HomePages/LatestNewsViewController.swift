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
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Latestnews/findAll"

    @IBOutlet var tableView: UITableView!
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let refreshControl = UIRefreshControl()
    var community = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        community = appDelegate.community
        fetchData()
        // Do any additional setup after loading the view.
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching 最新资讯 ...", attributes: nil)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchData()
    }
    
    
    // Mark: - Fetch data from server
    func fetchData() {
        AF.request(URL, method: .post, parameters: ["community": community]).responseJSON { (response) in
            if let json = response.value{
                let latestNewsArray = JSON(json).arrayValue
                self.newsArray = latestNewsArray
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
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
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            cell.title.font = cell.title.font.withSize(15)
            cell.newsText.font = cell.newsText.font.withSize(14)
        } else if (screenHeight < 668) {
            cell.title.font = cell.title.font.withSize(17)
            cell.newsText.font = cell.newsText.font.withSize(15)
        }
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 3, width: self.view.frame.size.width - 20, height: 300000))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)

        
        return cell
    }
}
