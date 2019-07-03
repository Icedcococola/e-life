//
//  PasswordRecoveryViewController.swift
//  e-life
//
//  Created by PalameMon on 7/3/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet var phonenum: UITextField!
    @IBOutlet var verification: UITextField!
    @IBOutlet var loginButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDesign()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func uiDesign(){
        loginButton.layer.cornerRadius = 20
        busAnimation()
        textFieldDesign(texfield: phonenum, icon_name: "password_icon", placeHolder: "手机号码")
        textFieldDesign(texfield: verification, icon_name: "password_icon", placeHolder: "验证码")
    }
    
    
    func busAnimation(){
        let animationView = AnimationView(name: "bus")
        print(self.view.frame.size.height)
        if (self.view.frame.size.height < 600) {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-150, width: self.view.frame.size.width, height: 150)
        } else if (self.view.frame.size.height < 668) {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-200, width: self.view.frame.size.width, height: 200)
        } else if (self.view.frame.size.height < 800)  {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-250, width: self.view.frame.size.width, height: 250)
        } else {
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-250, width: self.view.frame.size.width, height: 250)
        }
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
