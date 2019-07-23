//
//  FriendViewController.swift
//  e-life
//
//  Created by PalameMon on 7/16/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

protocol tablViewDelegate {
    func didTapDelete(id: String)
}

class CustomCell9 : UITableViewCell {
    
    var delegate: tablViewDelegate?
    var id : String = ""
    @IBOutlet var username: UILabel!
    @IBOutlet var deleteFriendButton: UIButton!
    @IBAction func deleteFriend(_ sender: Any) {
        delegate?.didTapDelete(id: id)
    }
}

class FriendViewController: UIViewController, tablViewDelegate {

    
    @IBOutlet var tableView: UITableView!
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Friend/findAll"
    let deleteURL = "http://elifedemo.vipgz1.idcfengye.com/Friend/deletefriend"
    var friendList : [JSON] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func didTapDelete(id: String) {
        let intID = Int(id)
        let user2 = friendList[intID!]["user2"].stringValue
        AF.request(deleteURL, method: .post, parameters: ["user1": self.appDelegate.username, "user2": user2]).responseJSON { (response) in
            if (response.response?.statusCode != 200) {
                SVProgressHUD.showError(withStatus: "删除失败")
            } else {
                SVProgressHUD.showSuccess(withStatus: "删除成功")
                self.fetchData()
            }
        }
    }
    
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["username": self.appDelegate.username]).responseJSON { (response) in
            if let json = response.value {
                let data = JSON(json).arrayValue
                self.friendList = data
                self.tableView.reloadData()
            }
        }
    }
    
}

extension FriendViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let screenHeight = self.view.frame.height
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell9
        cell.username.text = friendList[indexPath.row]["user2"].stringValue
        if (screenHeight < 569) {
            cell.username.font = cell.username.font.withSize(15)
        } else if (screenHeight < 669) {
            cell.username.font = cell.username.font.withSize(17)
        }
        cell.id = String(indexPath.row)
        cell.delegate = self
        cell.selectionStyle = .none
        return cell
    }
}
