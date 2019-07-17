//
//  EmergencyNoticeTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CustomCell : UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentText: UILabel!
    
}

class EmergencyNoticeTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    @IBOutlet var tableView: UITableView!
    
    var notiArray : [JSON] = [
        ["title": "I am the title", "detail": "I am the detail"],
        ["title": "I am the title", "detail": "I am the detail"],
        ["title": "I am the title", "detail": "I am the detail"]
    ]
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Emergencynotice/findAll"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        cell.selectionStyle = .none
        cell.titleLabel.text = notiArray[indexPath.row]["title"].stringValue
        cell.contentText.text = notiArray[indexPath.row]["detail"].stringValue
        
        cell.contentView.backgroundColor = UIColor.clear
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 8, width: self.view.frame.size.width - 20, height: 120))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [0.5, 0.5, 0.5, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 2.0
        whiteRoundedView.layer.shadowOffset = CGSize(width: -1, height: 1)
        whiteRoundedView.layer.shadowOpacity = 0.2
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)

        
        return cell
    }
 
    // Mark: - Fetch Data from server
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.appDelegate.community]).responseJSON { (response) in
            if let json = response.value{
                let notifications = JSON(json).arrayValue
                self.notiArray = notifications
                self.tableView.reloadData()
            }
        }
    }
}

extension EmergencyNoticeTableViewController {
    
}
