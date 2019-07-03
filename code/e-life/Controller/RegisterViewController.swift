//
//  RegisterViewController.swift
//  e-life
//
//  Created by PalameMon on 7/3/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie

class RegisterViewController: UIViewController {

    
    @IBOutlet var username: UITextField!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    
    @IBOutlet var password: UITextField!
   
    @IBOutlet var phonenumber: UITextField!
    @IBOutlet var phonenumberLabel: UILabel!
    
    @IBOutlet var verification: UITextField!
    @IBOutlet var verificationLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    
    //constraint
    @IBOutlet var bottomConstraint: NSLayoutConstraint!
    @IBOutlet var logoHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDesign()
        responsiveDesign()
        // Do any additional setup after loading the view.
    }
    
    func responsiveDesign(){
        let screenHeight = self.view.frame.height
        if (screenHeight < 569){
            print("hi")
            logoHeight.constant -= 20.0
            bottomConstraint.constant -= 5.0
            usernameLabel.font = UIFont(name: usernameLabel.font.fontName, size: 15.0)
             passwordLabel.font = UIFont(name: usernameLabel.font.fontName, size: 15.0)
             phonenumberLabel.font = UIFont(name: usernameLabel.font.fontName, size: 15.0)
             verificationLabel.font = UIFont(name: usernameLabel.font.fontName, size: 15.0)
           
            
        } else if (screenHeight < 669){
            logoHeight.constant -= 30.0
        } else {
            busAnimation()
        }
    }
    

    
    //
    func uiDesign(){
        registerButton.layer.cornerRadius = 20
        textFieldDesign(texfield: username, icon_name: "user_icon", placeHolder: "用户名")
        textFieldDesign(texfield: password, icon_name: "password_icon", placeHolder: "密码")
        textFieldDesign(texfield: phonenumber, icon_name: "password_icon", placeHolder: "手机号码")
        textFieldDesign(texfield: verification, icon_name: "password_icon", placeHolder: "验证码")
    }
    
    
    //bus animation
    func busAnimation(){
        let animationView = AnimationView(name: "bus")
        print(self.view.frame.size.height)
        animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-250, width: self.view.frame.size.width, height: 250)
        animationView.contentMode = .scaleAspectFill
        self.view.addSubview(animationView)
        self.view.sendSubviewToBack(animationView)
        animationView.loopMode = .loop
        animationView.play()
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
