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
    @IBOutlet var verifyButton: UIButton!
    
    
    var verificationNum : String = ""
    
    let URL = "http://elifedemo.free.idcfengye.com/User/register"
    
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
    
    @IBAction func getVerificationNum(_ sender: Any) {
        if (phonenumber.text!.isEmpty) {
            let alert = UIAlertController(title: "注意⚠️", message: "手机号码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                print("Cancelled")
            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Mark : - Request server to send verification number
            verifyButton.titleLabel?.text = "请稍微等待"
            AF.request("http://elifedemo.free.idcfengye.com/User/verify", method: .post, parameters: ["phonenum" : phonenumber.text!]).responseJSON { (response) in
                switch response.response?.statusCode {
                    case 200:
                        if let json = response.value {
                            let data = JSON(json)
                            print(data["num"])
                            if (data["num"].stringValue == "2") {
                                self.showAlert(message: "手机号码已存在")
                            }
                            self.verificationNum = data["num"].stringValue
                        }
                    default :
                        self.showAlert(message: "Error! Please try again!")
                    }
            }
        }
    }
    
    @IBAction func register(_ sender: Any) {
        if (username.text!.isEmpty || password.text!.isEmpty) {
            let alert = UIAlertController(title: "注意⚠️", message: "用户名或密码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
                print("Cancelled")
            }))
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
            // Mark: - Request server to register new user
            let parameter: Parameters = [
                "username": username.text!,
                "password": password.text!,
                "phonenum": phonenumber.text!,
                "community": "SJTU"
            ]
            
            AF.request(URL, method: .post, parameters: parameter, headers: nil, interceptor: nil).responseJSON{
                (response) in
                let status : Int = JSON(response.value)["num"].int!
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
                     self.performSegue(withIdentifier: "registerSuccessful", sender: nil)
                }
            }
        }
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


//    func retrieveData() {
//        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
//            let context = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<User>(entityName: "User")
//
//            do {
//                let results = try context.fetch(fetchRequest)
//
//                for result in results {
//                    if let username = result.username {
//                        print (username)
//                    }
//                }
//            } catch {
//                print ("Error fetching data")
//            }
//
//        }
//    }
}

