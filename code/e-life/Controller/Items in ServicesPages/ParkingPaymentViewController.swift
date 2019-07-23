//
//  ParkingPaymentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD

class ParkingPaymentViewController: UIViewController {

    @IBOutlet var infoView: UIView!
    @IBOutlet var paymentAmount: UILabel!
    @IBOutlet var payButton: UIButton!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Paid/getprice"
    let payURL = "http://elifedemo.vipgz1.idcfengye.com/Paid/havepaid"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func designUI(){
        infoView.layer.cornerRadius = 10
        payButton.layer.cornerRadius = 10
    }

    func fetchData() {
        SVProgressHUD.show(withStatus: "加载中")
        AF.request(URL, method: .post, parameters: ["username": self.appDelegate.username, "type": "tingche"]).responseJSON { (response) in
            if (response.response?.statusCode != 200) {
                SVProgressHUD.showError(withStatus: "Error")
            } else {
                if let json = response.value {
                    SVProgressHUD.dismiss()
                    let price = JSON(json)["num"].stringValue
                    self.paymentAmount.text = price + "元"
                }
            }
        }
    }
    @IBAction func pay(_ sender: Any) {
        AF.request(payURL, method: .post, parameters: ["username": self.appDelegate.username, "type": "tingche"]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                self.paymentAmount.text =  "0"
            }
        }
    }
}
