//
//  RegisterViewController.swift
//  e-life
//
//  Created by PalameMon on 7/3/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON
import CoreData
import SVProgressHUD

class RegisterViewController: UIViewController {

    
    @IBOutlet var username: UITextField!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var loginLabel: UIButton!
    @IBOutlet var registerLabel: UILabel!
    
    @IBOutlet var password: UITextField!
   
    @IBOutlet var phonenumber: UITextField!
    @IBOutlet var phonenumberLabel: UILabel!
    
    @IBOutlet var verification: UITextField!
    @IBOutlet var verificationLabel: UILabel!
    @IBOutlet var registerButton: UIButton!
    @IBOutlet var verifyButton: UIButton!
    @IBOutlet var communityLabel: UILabel!
    
    @IBOutlet var community: UIPickerView!
    
    var chosenCommunity = ""
    let communityArray : [String] = [
        "SJTU MINHANG",
        "SJTU XUHUI",
        "SJTU DONGQU",
        "SJTU NANQU"
    ]
    
    var verificationNum : String = ""
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/User/register"
    
    //constraint
    @IBOutlet var fromCenter: NSLayoutConstraint!
    @IBOutlet var registerButtonTop: NSLayoutConstraint!
    @IBOutlet var titleTop: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        uiDesign()
        responsiveDesign()
        // Do any additional setup after loading the view.
    }
    
    func responsiveDesign(){
        let screenHeight = self.view.frame.height
        let screenWidth = self.view.frame.width
        if (screenHeight < 569){ // Iphone SE
            titleTop.constant = 25
            fromCenter.constant = -80
            usernameLabel.font = usernameLabel.font.withSize(15)
            passwordLabel.font = passwordLabel.font.withSize(15)
            phonenumberLabel.font = phonenumberLabel.font.withSize(15)
            verificationLabel.font = verificationLabel.font.withSize(15)
            communityLabel.font = communityLabel.font.withSize(15)
            loginLabel.titleLabel!.font = loginLabel.titleLabel!.font.withSize(15)
            registerLabel.font = registerLabel.font.withSize(20)
            verifyButton.titleLabel!.font = verifyButton.titleLabel!.font.withSize(15)
            registerButton.titleLabel!.font = registerButton.titleLabel!.font.withSize(15)
            registerButtonTop.constant = 15
            registerButton.layer.cornerRadius = 10
        } else if  (screenHeight < 668) { //Iphone 8, 6, 6plus, 7
            fromCenter.constant = -110
            usernameLabel.font = usernameLabel.font.withSize(17)
            passwordLabel.font = passwordLabel.font.withSize(17)
            phonenumberLabel.font = phonenumberLabel.font.withSize(17)
            verificationLabel.font = verificationLabel.font.withSize(17)
            communityLabel.font = communityLabel.font.withSize(17)
            loginLabel.titleLabel!.font = loginLabel.titleLabel!.font.withSize(17)
            registerLabel.font = registerLabel.font.withSize(22)
            verifyButton.titleLabel!.font = verifyButton.titleLabel!.font.withSize(17)
            registerButton.titleLabel!.font = registerButton.titleLabel!.font.withSize(17)
            registerButtonTop.constant = 15
            registerButton.layer.cornerRadius = 10
        } else if (screenHeight < 813){ //Iphone X
            if (screenWidth > 375) { //Iphone 8plus and 7plus
                fromCenter.constant = -120
            } else {
                fromCenter.constant = -100
            }
        }
        else {
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
    
    @IBAction func getVerificationNum(_ sender: Any) {
        if (phonenumber.text!.isEmpty) {
            let alert = UIAlertController(title: "注意⚠️", message: "手机号码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Mark : - Request server to send verification number
            SVProgressHUD.show(withStatus: "正在发送短信")
            verifyButton.titleLabel?.text = "请稍微等待"
        AF.request("http://elifedemo.vipgz1.idcfengye.com/User/verify", method: .post, parameters: ["phonenum" : phonenumber.text!]).responseJSON { (response) in
                switch response.response?.statusCode {
                    case 200:
                        SVProgressHUD.showSuccess(withStatus: "短信已发送")
                        if let json = response.value {
                            let data = JSON(json)
                            print(data["num"])
                            if (data["num"].stringValue == "2") {
                                self.showAlert(message: "手机号码已存在")
                            }
                            self.verificationNum = data["num"].stringValue
                        }
                    default :
                        SVProgressHUD.dismiss()
                        self.showAlert(message: "Error! Please try again!")
                    }
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        if (username.text!.isEmpty || password.text!.isEmpty) {
            let alert = UIAlertController(title: "注意⚠️", message: "用户名或密码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if (phonenumber.text!.isEmpty) {
            let alert = UIAlertController(title: "注意⚠️", message: "手机号码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                print("Cancelled")
            }))
            self.present(alert, animated: true, completion: nil)
        } else if (verification.text!.isEmpty || verification.text! != verificationNum) {
            showAlert(message: "验证码不正确")
        }
        
        else {
            SVProgressHUD.show(withStatus: "正在注册！请稍微等待")
            // Mark: - Request server to register new user
            let parameter: Parameters = [
                "username": username.text!,
                "password": password.text!,
                "phonenum": phonenumber.text!,
                "community": chosenCommunity
            ]
            
            AF.request(URL, method: .post, parameters: parameter, headers: nil, interceptor: nil).responseJSON{
                (response) in
                if (response.response?.statusCode != 200) {
                    SVProgressHUD.dismiss()
                    SVProgressHUD.setMaximumDismissTimeInterval(2)
                    SVProgressHUD.showError(withStatus: "无法注册")
                } else {
                    let status : Int = JSON(response.value!)["num"].intValue
                    if (self.verification.text! != self.verificationNum) {
                        let alert = UIAlertController(title: "注意⚠️", message: "验证码不正确", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                            print("Cancelled")
                        }))
                        self.present(alert, animated: true, completion: nil)
                    } else if (status == 0)  {
                        self.showAlert(message: "用户已存在")
                    } else if (status == 1) {
                        self.showAlert(message: "手机已存在")
                    } else {
                        SVProgressHUD.dismiss()
                        SVProgressHUD.showSuccess(withStatus: "注册成功")
                        self.performSegue(withIdentifier: "registerSuccessful", sender: nil)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        phonenumber.resignFirstResponder()
        username.resignFirstResponder()
        verification.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func showAlert (message : String) {
        let alert = UIAlertController(title: "注意⚠️", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
            print("Cancelled")
        }))
        self.present(alert, animated: true, completion: nil)
    }
}

extension RegisterViewController {
    func saveData(username: String, password: String){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            guard let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else {return}

            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)

            newValue.setValue(username, forKey: "username")
            newValue.setValue(password, forKey: "password")

            do {
                try context.save()
                print("saved data")
            } catch {
                print("saving error")
            }
        }
    }
}

extension RegisterViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return communityArray.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return communityArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        chosenCommunity = communityArray[row]
    }
}

