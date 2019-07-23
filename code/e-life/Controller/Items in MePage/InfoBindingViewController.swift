//
//  InfoBindingViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class InfoBindingViewController: UIViewController {

    @IBOutlet var realName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var verification: UITextField!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/User/email"
    let bindingURL = "http://elifedemo.vipgz1.idcfengye.com/User/modifymessage"
    var verificationNUm = ""
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        realName.resignFirstResponder()
        email.resignFirstResponder()
        verification.resignFirstResponder()
    }
    
    @IBAction func getVerificationNum(_ sender: Any) {
        // Mark: - Send request to server to send verification number to user's email
        if (email.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "邮件地址不能为空")
        } else {
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show(withStatus: "正在发送验证码")
            AF.request(URL, method: .post, parameters: ["email": email.text!]).responseJSON { (response) in
                if (response.response?.statusCode != 200) {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showError(withStatus: "Error! Please Try Again")
                } else {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showSuccess(withStatus: "验证码已发送")
                    if let json = response.value{
                        let data = JSON(json)
                        self.verificationNUm = data["num"].stringValue
                    }
                }
            }
        }
    }
    
    @IBAction func infoBinding(_ sender: Any) {
        SVProgressHUD.setDefaultMaskType(.black)
        // Mark: - Match the verification from user and the server. Then send request to server for binding
        if (realName.text!.isEmpty){
            appDelegate.showAlert(viewcontroller: self, message: "真实姓名不能为空")
        } else if (email.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "邮件地址不能为空")
        } else if (verification.text!.isEmpty){
            appDelegate.showAlert(viewcontroller: self, message: "验证码不正确")
        } else if (verification.text! != verificationNUm) {
            appDelegate.showAlert(viewcontroller: self, message: "验证码不正确")
        } else {
            SVProgressHUD.show(withStatus: "正在验证中")
            AF.request(bindingURL, method: .post, parameters: ["username": appDelegate.username, "realname": realName.text!, "email": email.text!]).responseJSON { (response) in
                if (response.response?.statusCode == 200) {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showSuccess(withStatus: "信息绑定成功")
                } else {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.showError(withStatus: "绑定失败")
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
