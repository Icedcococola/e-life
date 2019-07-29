//
//  PayViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD
import TrPaySdk

class PayViewController: UIViewController, TrPayDelegate {

    @IBOutlet var payButton: UIButton!
    @IBOutlet var infoView: UIView!
    @IBOutlet var payAmount: UILabel!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Paid/getprice"
    let payURL = "http://elifedemo.vipgz1.idcfengye.com/Paid/havepaid"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let trpay = TrPay.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        fetchData()
        trpay.initPaySdk("576228fdd6ef4fb5903504628c7bdf2e", withChanel: "baidu")
        // Do any additional setup after loading the view.
    }
    
    func designUI(){
        payButton.layer.cornerRadius = 10
        infoView.layer.cornerRadius = 10
    }
    
    // Mark: - Fetch payment bill from server
    func fetchData() {
        SVProgressHUD.show(withStatus: "加载中")
        AF.request(URL, method: .post, parameters: ["username": self.appDelegate.username, "type": "wuye"]).responseJSON { (response) in
            if (response.response?.statusCode != 200) {
                SVProgressHUD.showError(withStatus: "Error")
            } else {
                if let json = response.value {
                    SVProgressHUD.dismiss()
                    let price = JSON(json)["num"].stringValue
                    self.payAmount.text = price + "元"
                }
            }
        }
    }
    
    
    @IBAction func pay(_ sender: Any) {
        SVProgressHUD.show(withStatus: "缴费中")
        AF.request(payURL, method: .post, parameters: ["username": self.appDelegate.username, "type": "wuye"]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                SVProgressHUD.dismiss()
                self.paying(amount: self.payAmount.text!)
                //SVProgressHUD.showSuccess(withStatus: "缴费成功")
                self.payAmount.text =  "已交付"
            } else {
                SVProgressHUD.showError(withStatus: "缴费失败！Please Try Again")
            }
        }
    }
    
    func paying(amount : String ){
        let price = Int(amount.dropLast())! * 100
        TrPay.shareInstance().call("物业管理费", withOutTradeno: "fadsfsdaf" , withAmount: price, withBackparams: "name=支付测试&age=100", withNotifyurl: payURL, payuserid: "1049673937@qq.com", with: self)
    }
    
    func onPayFinish(_ outtradeno: String!, resultCode: Int32, resultString: String!, payType: Int, amount: Int, tradename: String!) {
        print ("Hi")
    }
    
    
}

