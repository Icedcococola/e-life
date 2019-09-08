//
//  RequestViewController.swift
//  e-life
//
//  Created by PalameMon on 7/16/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class RequestViewController: UIViewController {

    @IBOutlet var requestProduct: UITextField!
    @IBOutlet var postButton: UIButton!
    @IBOutlet var date: UIDatePicker!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Desired/add"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProduct.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        requestProduct.resignFirstResponder()
    }
    
    
    @IBAction func sendRequest(_ sender: Any) {
        if (requestProduct.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "商品名不能为空")
        } else {
            sendData()
        }
    }
    
    // Mark: - Make request
    func sendData(){
        let productName = requestProduct.text!
        let deadline = date.date
        AF.request(URL, method: .post, parameters: ["publisher": self.appDelegate.username, "community": self.appDelegate.community, "goods": productName, "deadline": deadline]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                self.navigationController?.popViewController(animated: true)
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "发布失败！请注意您的网络！")
            }
        }
    }

}
