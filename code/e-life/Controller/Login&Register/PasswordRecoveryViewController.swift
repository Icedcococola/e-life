//
//  PasswordRecoveryViewController.swift
//  e-life
//
//  Created by PalameMon on 7/3/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON
import SVProgressHUD

class PasswordRecoveryViewController: UIViewController {

    @IBOutlet var phonenum: UITextField!
    @IBOutlet var verification: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var phoneNumLabel: UILabel!
    @IBOutlet var veriLabel: UILabel!
    @IBOutlet var titleTop: NSLayoutConstraint!
    @IBOutlet var titleBottom: NSLayoutConstraint!
    
    var verificationNum : String = ""
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/User/fetchpassword"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDesign()
        responsiveDesign()
        // Do any additional setup after loading the view.
    }
    
    func responsiveDesign(){
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            titleTop.constant = 60
            titleBottom.constant = 40
            titleLabel.font = titleLabel.font.withSize(20)
            phoneNumLabel.font = phoneNumLabel.font.withSize(15)
            veriLabel.font = veriLabel.font.withSize(15)
            loginButton.titleLabel!.font = loginButton.titleLabel!.font.withSize(15)
        } else if (screenHeight < 668) {
            titleLabel.font = titleLabel.font.withSize(22)
            phoneNumLabel.font = phoneNumLabel.font.withSize(17)
            veriLabel.font = veriLabel.font.withSize(17)
            loginButton.titleLabel!.font = loginButton.titleLabel!.font.withSize(17)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phonenum.resignFirstResponder()
        verification.resignFirstResponder()
    }
    
    func uiDesign(){
        loginButton.layer.cornerRadius = 20
        busAnimation()
        textFieldDesign(texfield: phonenum, icon_name: "password_icon", placeHolder: "手机号码")
        textFieldDesign(texfield: verification, icon_name: "password_icon", placeHolder: "验证码")
    }
    
    
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

    @IBAction func getVerification(_ sender: Any) {
        if (phonenum.text!.isEmpty){
            appDelegate.showAlert(viewcontroller: self, message: "手机号码不能为空")
        } else {
            SVProgressHUD.show(withStatus: "正在发送短信")
            //Mark: - Request server to send verification
            AF.request(URL, method: .post, parameters: ["phonenum" : phonenum.text!]).responseJSON { (response) in
                if (response.response?.statusCode == 200){
                    if let json = response.value{
                        let status = JSON(json)["num"].stringValue
                        if (status == "0") {
                            SVProgressHUD.dismiss()
                            self.appDelegate.showAlert(viewcontroller: self, message: "手机不存在")
                        } else {
                            SVProgressHUD.showSuccess(withStatus: "短信已发送")
                            self.verificationNum = status
                        }
                    }
                } else {
                    //SVProgressHUD.setDefaultStyle(.custom)
                    SVProgressHUD.setDefaultMaskType(.black)
                    SVProgressHUD.showError(withStatus: "网络出了问题。Please Try Again!")
                }
            }
        }
    }
    
    @IBAction func confirm(_ sender: Any) {
        if (verification.text!.isEmpty || verification.text! != verificationNum) {
            appDelegate.showAlert(viewcontroller: self, message: "验证码不正确")
        } else if (phonenum.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "手机号码不能为空")
        } else {
            performSegue(withIdentifier: "gotoNewPassword", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is NewPasswordViewController {
            let vc = segue.destination as? NewPasswordViewController
            vc?.phonenum = self.phonenum.text!
        }
    }
}
