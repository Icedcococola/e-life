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
    let URL = "http://elifedemo.free.idcfengye.com/Friend/findAll"
    let deleteURL = "http://elifedemo.free.idcfengye.com/Friend/deletefriend"
    var friendList : [JSON] = []
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username = appDelegate.username
        fetchData()

        // Do any additional setup after loading the view.
    }
    
    func didTapDelete(id: String) {
        AF.request(deleteURL, method: .post, parameters: ["username": username]).responseJSON { (response) in
            if let json = response.value {
                let data = JSON(json).arrayValue
                self.friendList = data
                self.tableView.reloadData()
            }
        }
    }
    
    func fetchData(){
        print (username)
        AF.request(URL, method: .post, parameters: ["username": username]).responseJSON { (response) in
            if let json = response.value {
                let data = JSON(json).arrayValue
                print (data)
                self.friendList = data
                self.tableView.reloadData()
                print (self.friendList)
            }
        }
    }
    
    

}

extension FriendViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print (friendList.count)
        return friendList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell9
        print ("fadsf")
        cell.username.text = friendList[indexPath.row]["user2"].stringValue
        //cell.id = friendList[indexPath.row]["id"].stringValue
        return cell
    }
}
