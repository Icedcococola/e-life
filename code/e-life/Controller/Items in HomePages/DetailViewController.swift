//
//  DetailViewController.swift
//  e-life
//
//  Created by PalameMon on 7/15/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class DetailViewController: UIViewController {
    
    var id : String = ""

    @IBOutlet var image: UIImageView!
    @IBOutlet var supplier: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var leftAmount: UILabel!
    @IBOutlet var timer: UILabel!
    @IBOutlet var detail: UILabel!
    @IBOutlet var add: UIButton!
    @IBOutlet var buyAmount: UITextField!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Goods/finddetail"
    let addURL = "http://elifedemo.vipgz1.idcfengye.com/Goodsuser/add"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        add.layer.cornerRadius = 10
        print (id)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        username = appDelegate.username
        fetchData()
    }
    
    // Make request for data
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["username": self.username, "goodsid": id]).responseJSON { (response) in
            if let json = response.value {
                let data = JSON(json)
                let num = data["num"].stringValue
                self.supplier.text = data["store"].stringValue
                self.price.text = data["price"].stringValue
                self.leftAmount.text = data["remainingnum"].stringValue
                self.timer.text = data["deadline"].stringValue
                self.detail.text = data["detail"].stringValue
                if (num != "0"){
                    self.setBought(num: num)
                }
            }
        }
    }
    @IBAction func join(_ sender: Any) {
        AF.request(addURL, method: .post, parameters: ["num": buyAmount.text!, "goodsid" : id, "username": self.username]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                SVProgressHUD.showSuccess(withStatus: "加入成功")
                self.fetchData()
            } else {
                SVProgressHUD.showError(withStatus: "加入失败")
            }
        }
    }
    
    func setBought(num : String) {
        buyAmount.text = num
        buyAmount.isEnabled = false
        add.backgroundColor = .lightGray
        add.setTitle("已加入", for: .disabled)
        //add.titleLabel?.text = "已加入"
        add.isEnabled = false
    }
    
}
