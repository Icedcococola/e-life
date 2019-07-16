//
//  AddFriendViewController.swift
//  e-life
//
//  Created by PalameMon on 7/16/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddFriendViewController: UIViewController {


    @IBOutlet var friendName: UITextField!
    
    let URL = "http://elifedemo.free.idcfengye.com/Services/find"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addFriend(_ sender: Any) {
        let name = friendName.text!
        if (name.isEmpty) {
            appDelegate.showAlert(viewscontroler: self, message: "好友名不能为空")
        } else {
            AF.request(URL, method: .post, parameters: ["name": name]).responseJSON { (response) in
                if let json = response.value {
                    let data = JSON(json)
                    if (data["num"].stringValue == "0") {
                        self.appDelegate.showAlert(viewscontroler: self, message: "找不到")
                    } else {
                        self.appDelegate.showAlert(viewscontroler: self, message: "好友申请已发送")
                    }
                }
            }
        }
    }
    
}
