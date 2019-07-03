//
//  ViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie

class LoginViewController: UIViewController {
    
    //text fields outlets
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var login: UILabel!
    //login button outlet
    @IBOutlet var loginButton: UIButton!
    
    //constraint outlets
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var loginLabel: NSLayoutConstraint!
    @IBOutlet var logoHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        busAnimation()
        uiDesign()
    }
    
    func busAnimation(){
        let animationView = AnimationView(name: "bus")
        print(self.view.frame.size.height)
        if (self.view.frame.size.height < 600) {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-150, width: self.view.frame.size.width, height: 150)
            bottomConstraint.constant = 170
            logoHeight.constant -= 30
        } else if (self.view.frame.size.height < 668) {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-200, width: self.view.frame.size.width, height: 200)
            bottomConstraint.constant = 220
        } else if (self.view.frame.size.height < 800)  {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-250, width: self.view.frame.size.width, height: 250)
            bottomConstraint.constant = 255
        } else {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-250, width: self.view.frame.size.width, height: 250)
            bottomConstraint.constant = 320
        }
        animationView.contentMode = .scaleAspectFill
        self.view.addSubview(animationView)
        self.view.sendSubviewToBack(animationView)

        animationView.loopMode = .loop
        animationView.play()
    }
    
    func uiDesign(){
        loginButton.layer.cornerRadius = 20
        textFieldDesign(texfield: username, icon_name: "user_icon", placeHolder: "用户名")
        textFieldDesign(texfield: password, icon_name: "password_icon", placeHolder: "密码")
    }
    
    //customize textfield
    func textFieldDesign (texfield : UITextField, icon_name : String, placeHolder : String){
        texfield.borderStyle = .none
        texfield.layoutIfNeeded()
        
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor(red: 216/255.0, green: 216/255.0, blue: 216/255.0, alpha: 100).cgColor
        
        border.frame = CGRect(x: 0, y: texfield.frame.size.height - width, width:  texfield.frame.size.width, height: texfield.frame.size.height)
        border.borderWidth = width
        texfield.layer.addSublayer(border)
        texfield.layer.masksToBounds = true
        
        texfield.layer.addSublayer(border)
        texfield.layer.masksToBounds = true
        
        texfield.leftViewMode = .always
        let userImage = UIImage(named: icon_name)
        let placeholderImage = UIImageView(frame: CGRect(x: 0, y: 0, width: userImage!.size.width/2, height: userImage!.size.height/2))
        placeholderImage.image = userImage
        texfield.leftView = placeholderImage
        
        texfield.placeholder = placeHolder
        texfield.textAlignment = .center
        
    }


}

