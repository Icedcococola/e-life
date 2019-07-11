//
//  ParkingPaymentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class ParkingPaymentViewController: UIViewController {

    @IBOutlet var infoView: UIView!
    @IBOutlet var paymentAmount: UILabel!
    @IBOutlet var payButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        // Do any additional setup after loading the view.
    }
    
    func designUI(){
        infoView.layer.cornerRadius = 10
        payButton.layer.cornerRadius = 10
    }

    // MARK: - Fetch pay amount from server and change paymentAmount variable
    func request() {
        //paymentAmount.text = //request from server
    }
    

}
