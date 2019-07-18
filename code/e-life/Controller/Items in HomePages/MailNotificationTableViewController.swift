//
//  MailNotificationTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class CustomCell2 : UITableViewCell{
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentText: UILabel!
}

class MailNotificationTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var notiArray : [JSON] = []
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Activity/findAll"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var community = ""
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        community = appDelegate.community
        fetchData()
       
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell2
        print(indexPath.row)
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
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 30000))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0

        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)

        return cell
    }
    
    // Mark: - Fetch data from server
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.community]).responseJSON { (response) in
            if let json = response.value{
                let noti = JSON(json).arrayValue
                self.notiArray = noti
                self.tableView.reloadData()
            }
        }
    }
}

