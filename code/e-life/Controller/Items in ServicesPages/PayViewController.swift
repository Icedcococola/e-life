//
//  PayViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class PayViewController: UIViewController {

    @IBOutlet var payButton: UIButton!
    @IBOutlet var infoView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        // Do any additional setup after loading the view.
    }
    
    func designUI(){
        payButton.layer.cornerRadius = 10
        infoView.layer.cornerRadius = 10
    }
    
    // Mark: - Fetch payment bill from server
    
}
