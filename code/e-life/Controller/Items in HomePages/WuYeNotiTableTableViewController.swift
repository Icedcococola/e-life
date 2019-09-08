//
//  WuYeNotiTableTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomCell1 : UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentText: UILabel!
}

class WuYeNotiTableTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var notiArray : [JSON] = []
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Propertynotice/findAll"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(refreshWeatherData(_:)), for: .valueChanged)
        refreshControl.attributedTitle = NSAttributedString(string: "Fetching 物业通知 ...", attributes: nil)
        refreshControl.tintColor = UIColor(red:0.25, green:0.72, blue:0.85, alpha:1.0)
        fetchData()
    }
    
    @objc private func refreshWeatherData(_ sender: Any) {
        // Fetch Weather Data
        fetchData()
    }
    

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell1
        cell.titleLabel.text = notiArray[indexPath.row]["title"].stringValue
        cell.contentText.text = notiArray[indexPath.row]["detail"].stringValue
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(15)
            cell.contentText.font = cell.contentText.font.withSize(14)
        } else if (screenHeight < 668) {
            cell.titleLabel.font = cell.titleLabel.font.withSize(17)
            cell.contentText.font = cell.contentText.font.withSize(15)
        }
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 300000))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        
        return cell
    }
    
    // Mark: - Fetch data from server
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.appDelegate.community]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                if let json = response.value{
                    let wuyeNoti = JSON(json).arrayValue
                    self.notiArray = wuyeNoti
                    self.tableView.reloadData()
                    self.refreshControl.endRefreshing()
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "加载失败！请注意您的网络")
            }
        }
    }
    
}
