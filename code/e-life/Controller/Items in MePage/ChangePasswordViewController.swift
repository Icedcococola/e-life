//
//  ChangePasswordViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {

    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    
    @IBAction func changePassword(_ sender: Any) {
        if (newPassword.text != confirmPassword.text) {
            // Mark: - Alert user
        } else {
            // Mark: - Request server to change the password
        }
    }
    
    
}
