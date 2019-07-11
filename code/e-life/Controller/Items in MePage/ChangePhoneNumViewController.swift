//
//  ChangePhoneNumViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class ChangePhoneNumViewController: UIViewController {

    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var newPhoneNum: UITextField!
    @IBOutlet var verification: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    @IBAction func getVerificationNum(_ sender: Any) {
        // Mark: - Send request to server to send verification number to user's phone
    }
    
    @IBAction func changePhoneNum(_ sender: Any) {
        // Mark: - Change phone number
    }
    

}
