//
//  MarketDetailViewController.swift
//  e-life
//
//  Created by PalameMon on 8/28/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON

class MarketDetailViewController: UIViewController {

    @IBOutlet var marketName: UILabel!
    @IBOutlet var marketAddress: UILabel!
    @IBOutlet var marketPhoneNum: UILabel!
    @IBOutlet var marketImage: UIImageView!
    @IBOutlet var callButton: UIButton!
    var market : JSON = JSON()
    override func viewDidLoad() {
        super.viewDidLoad()
        callButton.layer.cornerRadius = 10;
        marketName.text = market["storename"].stringValue
        marketAddress.text = market["address"].stringValue
        marketPhoneNum.text = market["phonenum"].stringValue
        marketImage.downloaded(from: market["img"].stringValue)
        print (market["img"].stringValue)
        // Do any additional setup after loading the view.
    }
    @IBAction func calling(_ sender: Any) {
        callNumber(phoneNumber: market["phonenum"].stringValue)
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
