//
//  MapDetailViewController.swift
//  e-life
//
//  Created by PalameMon on 7/23/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class MapDetailViewController: UIViewController {

    var storeName : String = ""
    var address : String = ""
    var discount : String = ""
    var imageUrl : String = ""
    var phone : String = ""
    @IBOutlet var phoneNum: UILabel!
    @IBOutlet var storeNameLabel: UILabel!
    @IBOutlet var discountLabel: UILabel!
    @IBOutlet var addressLabel: UILabel!
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    
    //constraint
    @IBOutlet var imageHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storeNameLabel.text = storeName
        discountLabel.text = discount
        addressLabel.text = address
        phoneNum.text = phone
        
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            storeNameLabel.font = storeNameLabel.font.withSize(15)
            discountLabel.font = discountLabel.font.withSize(15)
            addressLabel.font = addressLabel.font.withSize(15)
            label1.font = label1.font.withSize(15)
            label2.font = label2.font.withSize(15)
            label3.font = label3.font.withSize(15)
            imageHeight.constant = 200
        } else if (screenHeight < 668) {
            storeNameLabel.font = storeNameLabel.font.withSize(17)
            discountLabel.font = discountLabel.font.withSize(17)
            addressLabel.font = addressLabel.font.withSize(17)
            label1.font = label1.font.withSize(17)
            label2.font = label2.font.withSize(17)
            label3.font = label3.font.withSize(17)
            imageHeight.constant = 250
        }
        
        //imageView.image = UIImage(named: image)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print (imageUrl)
        imageView.downloaded(from: imageUrl)
    }
}
