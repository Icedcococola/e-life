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
import SVProgressHUD

class AddFriendViewController: UIViewController {


    @IBOutlet var friendName: UITextField!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Friendsapplication/applyfriend"
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
            SVProgressHUD.show(withStatus: "正在找好友")
            AF.request(URL, method: .post, parameters: ["applied": name, "applyfor": self.appDelegate.username]).responseJSON { (response) in if (response.response?.statusCode != 200) {
                    SVProgressHUD.showError(withStatus: "Please Try Again!")
                } else {
                    if let json = response.value {
                        SVProgressHUD.dismiss()
                        let data = JSON(json)
                        print (data)
                        if (data["num"].stringValue == "0") {
                            self.appDelegate.showAlert(viewscontroler: self, message: "已是好友")
                        } else if (data["num"].stringValue == "1") {
                            self.appDelegate.showAlert(viewscontroler: self, message: "该用户名不存在")
                        } else {
                            self.appDelegate.showAlert(viewscontroler: self, message: "好友申请已发送")
                        }
                    }
                }
            }
        }
    }
    
}
