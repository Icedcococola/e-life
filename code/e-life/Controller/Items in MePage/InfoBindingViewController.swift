//
//  InfoBindingViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class InfoBindingViewController: UIViewController {

    @IBOutlet var realName: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var verification: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    @IBAction func getVerificationNum(_ sender: Any) {
        // Mark: - Send request to server to send verification number to user's email
    }
    
    @IBAction func infoBinding(_ sender: Any) {
        // Mark: - Match the verification from user and the server. Then send request to server for binding
        
    }
    

}
