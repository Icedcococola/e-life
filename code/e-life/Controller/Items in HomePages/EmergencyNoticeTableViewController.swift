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
    
    var notiArray : [JSON] = []
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
        cell.titleLabel.text = notiArray[indexPath.row]["title"].stringValue
        cell.contentText.text = notiArray[indexPath.row]["detail"].stringValue
        cell.layer.cornerRadius = 15
        return cell
    }
 
    // Mark: - Fetch Data from server
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.appDelegate.community]).responseJSON { (response) in
            if let json = response.value{
                let notifications = JSON(json).arrayValue
                self.notiArray = notifications
                print (self.notiArray)
                self.tableView.reloadData()
            }
        }
    }
}
