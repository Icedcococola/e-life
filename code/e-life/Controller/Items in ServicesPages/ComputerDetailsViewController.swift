//
//  ComputerDetailsViewController.swift
//  e-life
//
//  Created by PalameMon on 8/28/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON

class ComputerDetailsViewController: UIViewController {

    @IBOutlet var shopImage: UIImageView!
    @IBOutlet var shopName: UILabel!
    @IBOutlet var shopAddress: UILabel!
    @IBOutlet var shopPhoneNum: UILabel!
    var shop : JSON = JSON()
    @IBOutlet var callButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        callButton.layer.cornerRadius = 10;
        shopName.text = shop["storename"].stringValue
        shopPhoneNum.text = shop["phonenum"].stringValue
        shopAddress.text = shop["address"].stringValue
        shopImage.downloaded(from: shop["img"].stringValue)
        // Do any additional setup after loading the view.
    }
    @IBAction func call(_ sender: Any) {
        callNumber(phoneNumber: shop["phonenum"].stringValue)
    }
    
    func callNumber(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                print("Calling")
            } else {
                UIApplication.shared.openURL(url as URL)
                print("Calling")
            }
        }
    }
}
