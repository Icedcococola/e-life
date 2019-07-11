//
//  ChangeNameViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class ChangeNameViewController: UIViewController {

    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var newName: UITextField!
    @IBOutlet var confirmNewName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        confirmButton.layer.cornerRadius = 15
        // Do any additional setup after loading the view.
    }
    @IBAction func changeName(_ sender: Any) {
        if (newName.text != confirmNewName.text){
            // Mark: - Alert user
        } else {
            // Mark: - Request server to change the name for the user
        }
    }
    
}
