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
    
    let URL = "http://elifedemo.free.idcfengye.com/Desired/add"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var community = ""
    var username = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestProduct.layer.cornerRadius = 10
        postButton.layer.cornerRadius = 10
        username = appDelegate.username
        community = appDelegate.community
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func sendRequest(_ sender: Any) {
        if (requestProduct.text!.isEmpty) {
            appDelegate.showAlert(viewscontroler: self, message: "商品名不能为空")
        } else {
            sendData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoProductList") {
            let destVC = segue.destination as! BulkPurchaseViewController
            destVC.haveNewProduct = sender! as! Bool
        }
    }
    
    // Mark: - Make request
    func sendData(){
        let productName = requestProduct.text!
        let deadline = date.date
        print (deadline)
        AF.request(URL, method: .post, parameters: ["publisher": username, "community": community, "goods": productName, "deadline": deadline]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                self.performSegue(withIdentifier: "gotoProductList", sender: true)
            } else {
                self.appDelegate.showAlert(viewscontroler: self, message: "网络不。Please try again!")
            }
        }
    }

}
