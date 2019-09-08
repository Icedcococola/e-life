//
//  PropertyRepairViewController.swift
//  e-life
//
//  Created by PalameMon on 8/28/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire
import SVProgressHUD

class PropertyRepairViewController: UIViewController {

    @IBOutlet var submitButton: UIButton!
    @IBOutlet var phoneNum: UITextField!
    @IBOutlet var address: UITextView!
    @IBOutlet var reason: UITextView!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Servicea/weixiu"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 10
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phoneNum.resignFirstResponder()
        address.resignFirstResponder()
        reason.resignFirstResponder()
    }
    
    @IBAction func submit(_ sender: Any) {
        if (phoneNum.text!.isEmpty || address.text!.isEmpty || reason.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "请完成所有必填的表格")
        } else {
            let parameter = ["username": appDelegate.username, "phonenum": phoneNum.text!, "community": appDelegate.community, "address": address.text!, "reason": reason.text!]
            AF.request(URL, method: .get, parameters: parameter).responseJSON { (response) in
                if (response.response?.statusCode == 200) {
                    SVProgressHUD.showSuccess(withStatus: "提交成功")
                } else {
                    self.appDelegate.showAlert(viewcontroller: self, message: "提交失败!")
                }
            }
        }
    }
    

}
