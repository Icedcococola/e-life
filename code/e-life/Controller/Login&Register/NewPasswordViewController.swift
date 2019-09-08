//
//  NewPasswordViewController.swift
//  e-life
//
//  Created by PalameMon on 7/3/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SVProgressHUD

class NewPasswordViewController: UIViewController {

    @IBOutlet var newPassword: UITextField!
    @IBOutlet var confirmPassword: UITextField!
    @IBOutlet var confirmButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var newPasswordLabel: UILabel!
    @IBOutlet var confirmPasswordLabel: UILabel!
    @IBOutlet var titleTop: NSLayoutConstraint!
    @IBOutlet var titleBottom: NSLayoutConstraint!
    
    var phonenum : String = ""
    let URL = "http://elifedemo.vipgz1.idcfengye.com/User/modifypassword"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDesign()
        responsiveDesign()
        // Do any additional setup after loading the view.
    }
    
    func responsiveDesign () {
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            titleTop.constant = 60
            titleBottom.constant = 40
            titleLabel.font = titleLabel.font.withSize(20)
            newPasswordLabel.font = newPasswordLabel.font.withSize(15)
            confirmPasswordLabel.font = confirmPasswordLabel.font.withSize(15)
            confirmButton.titleLabel!.font = confirmButton.titleLabel!.font.withSize(15)
        } else if (screenHeight < 668) {
            titleLabel.font = titleLabel.font.withSize(22)
            newPasswordLabel.font = newPasswordLabel.font.withSize(17)
            confirmPasswordLabel.font = confirmPasswordLabel.font.withSize(17)
            confirmButton.titleLabel!.font = confirmButton.titleLabel!.font.withSize(17)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        newPassword.resignFirstResponder()
        confirmPassword.resignFirstResponder()
    }
    
    
    func uiDesign(){
        confirmButton.layer.cornerRadius = 20
        busAnimation()
        textFieldDesign(texfield: newPassword, icon_name: "password_icon", placeHolder: "新密码")
        textFieldDesign(texfield: confirmPassword, icon_name: "password_icon", placeHolder: "确认密码")
    }
   
    // bus animation
    func busAnimation(){
        let animationView = AnimationView(name: "bus")
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

    @IBAction func confirm(_ sender: Any) {
        if (newPassword.text! != confirmPassword.text! || newPassword.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "密码不匹配")
        } else {
            // Mark: - Request server to change password for the user with phonenum
            SVProgressHUD.setDefaultMaskType(.black)
            SVProgressHUD.show(withStatus: "正在修改密码")
            AF.request(URL, method: .post, parameters: ["phonenum": phonenum, "password": newPassword.text!]).responseJSON { (response) in
                if (response.response?.statusCode != 200) {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setDefaultMaskType(.black)
                    SVProgressHUD.showError(withStatus: "修改失败! 请注意您的网络")
                } else {
                    SVProgressHUD.dismiss()
                    self.performSegue(withIdentifier: "gotoLogIn", sender: nil)
                }
            }
        }
    }
}
