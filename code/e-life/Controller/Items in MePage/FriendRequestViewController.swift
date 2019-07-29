//
//  FriendRequestViewController.swift
//  e-life
//
//  Created by PalameMon on 7/16/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


protocol friendTableDelegate {
    func didTappedAccept(id : String)
    func didTappedReject(id : String)
}

class CustomCell8 : UITableViewCell {
    
    var id = ""
    var delegate : friendTableDelegate?
    @IBOutlet var username: UILabel!
    @IBAction func accept(_ sender: Any) {
        delegate?.didTappedAccept(id : id)
    }
    @IBAction func reject(_ sender: Any) {
        delegate?.didTappedReject(id : id)
    }
}

class FriendRequestViewController: UIViewController, friendTableDelegate{
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var username: UITableView!
    
    var friendRequestArray : [JSON] = []
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Friendsapplication/findAll"
    let acceptURL = "http://elifedemo.vipgz1.idcfengye.com/Friendsapplication/Agree"
    let rejectURL = "http://elifedemo.vipgz1.idcfengye.com/Friendsapplication/refuse"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        SVProgressHUD.setMinimumDismissTimeInterval(3)
        if let rootViewController = appDelegate.window?.rootViewController as! UITabBarController?{
            if let tabItems = rootViewController.tabBar.items {
                let tabItem = tabItems[2]
                tabItem.badgeValue = .none
            }
        }
        // Do any additional setup after loading the view.
    }    
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["applied": self.appDelegate.username]).responseJSON { (response) in
            if (response.response?.statusCode != 200) {
                SVProgressHUD.showError(withStatus: "Error！")
            } else {
                if let json = response.value {
                    let friendArray = JSON(json).arrayValue
                    self.friendRequestArray = friendArray
                    self.tableView.reloadData()
                }
            }
        }
    }    
    
    func didTappedAccept(id : String) {
        let intId = Int(id)
        let applyfor = friendRequestArray[intId!]["applyfor"].stringValue
        AF.request(acceptURL, method: .post, parameters: ["applied": self.appDelegate.username, "applyfor": applyfor]).responseJSON { (response) in if (response.response?.statusCode != 200) {
            SVProgressHUD.showError(withStatus: "Error")
        } else {
            self.appDelegate.socket.emit("accept", ["username": self.appDelegate.username, "name": applyfor])
            SVProgressHUD.showSuccess(withStatus: "好友申请已接受")
            //self.friendRequestArray.remove(at: intId!)
            //self.tableView.reloadData()
            self.fetchData()
            }
        }
    }
    
    func didTappedReject(id : String) {
        let intId = Int(id)
        let applyfor = friendRequestArray[intId!]["applyfor"].stringValue
        AF.request(rejectURL, method: .post, parameters: ["applied": self.appDelegate.username, "applyfor": applyfor]).responseJSON { (response) in if (response.response?.statusCode != 200) {
            SVProgressHUD.showError(withStatus: "Error")
        } else {
            self.appDelegate.socket.emit("reject", ["username": self.appDelegate.username, "name": applyfor])
            SVProgressHUD.showSuccess(withStatus: "好友申请已拒绝")
            //self.friendRequestArray.remove(at: intId!)
            //self.tableView.reloadData()
            self.fetchData()
            }
        }
    }
    
    
}


extension FriendRequestViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendRequestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let screenHeight = self.view.frame.height
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell8
        cell.id = String(indexPath.row)
        cell.delegate = self
        cell.selectionStyle = .none
        cell.username.text = friendRequestArray[indexPath.row]["applyfor"].stringValue
        if (screenHeight < 569) {
            cell.username.font = cell.username.font.withSize(15)
        } else if (screenHeight < 669) {
            cell.username.font = cell.username.font.withSize(17)
        }
        return cell
    }
    
    
}
