//
//  ViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Lottie
import Alamofire
import SwiftyJSON
import SVProgressHUD
import CoreData
import UserNotifications

class LoginViewController: UIViewController {
    
    //text fields outlets
    @IBOutlet var username: UITextField!
    @IBOutlet var password: UITextField!
    //login button outlet
    @IBOutlet var loginButton: UIButton!
    
    //constraint outlets
    
    @IBOutlet var loginLabel: UILabel!
    @IBOutlet var usernameLabel: UILabel!
    @IBOutlet var passwordLabel: UILabel!
    @IBOutlet var logoWidth: NSLayoutConstraint!
    @IBOutlet var logoHeight: NSLayoutConstraint!
    @IBOutlet var noAccountLabel: UILabel!
    @IBOutlet var registerLabel: UIButton!
    
    //constraint
    
    var isLoggedIn : Bool = false
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/User/login"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        busAnimation()
        uiDesign()
        responsiveDesign()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        username.resignFirstResponder()
        password.resignFirstResponder()
    }
    
    func responsiveDesign() {
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            usernameLabel.font = usernameLabel.font.withSize(15)
            passwordLabel.font = passwordLabel.font.withSize(15)
            noAccountLabel.font = noAccountLabel.font.withSize(15)
            loginLabel.font = loginLabel.font.withSize(20)
            loginButton.titleLabel!.font = loginButton.titleLabel!.font.withSize(15)
            registerLabel.titleLabel!.font = registerLabel.titleLabel!.font.withSize(15)
            
        } else if (screenHeight < 668) {
            loginLabel.font = loginLabel.font.withSize(22)
            usernameLabel.font = usernameLabel.font.withSize(17)
            passwordLabel.font = passwordLabel.font.withSize(17)
            noAccountLabel.font = noAccountLabel.font.withSize(17)
            loginButton.titleLabel!.font = loginButton.titleLabel!.font.withSize(17)
            registerLabel.titleLabel!.font = registerLabel.titleLabel!.font.withSize(17)
        }
    
    }
    
    func busAnimation(){
        let animationView = AnimationView(name: "bus")
        print(self.view.frame.size.height)
        if (self.view.frame.size.height < 600) {
            loginLabel.font = loginLabel.font.withSize(20)
            usernameLabel.font = usernameLabel.font.withSize(15)
            passwordLabel.font = passwordLabel.font.withSize(15)
            noAccountLabel.font = noAccountLabel.font.withSize(15)
            loginButton.titleLabel!.font = loginButton.titleLabel!.font.withSize(15)
            registerLabel.titleLabel!.font = registerLabel.titleLabel!.font.withSize(15)
            logoWidth.constant = 100
            logoHeight.constant = 70
            animationView.frame = CGRect(x: 0, y: self.view.frame.size.height-170, width: self.view.frame.size.width, height: 160)
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
    
    
    @IBAction func logInTapped(_ sender: Any) {
        loggingIn()
    }
    
    // Mark: - Login user
    func loggingIn(){
        let userName : String = username.text!
        let passWord : String = password.text!
        if (userName.isEmpty || passWord.isEmpty){
            let alert = UIAlertController(title: "注意⚠️", message: "用户名或密码不能为空", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in

            }))
            self.present(alert, animated: true, completion: nil)
        } else {
            // Mark: - Request for user information and store in core data
            SVProgressHUD.show(withStatus: "正在登录中")
            let parameter = ["username": userName, "password": passWord]
            AF.request(URL, method: .post, parameters: parameter).responseJSON { (response) in
                if (response.response?.statusCode != 200) {
                    SVProgressHUD.dismiss()
                    self.appDelegate.showAlert(viewscontroler: self, message: "Error! Please try again!")
                } else {
                    SVProgressHUD.dismiss()
                    let status : Int = JSON(response.value!)["num"].intValue
                    print (status)
                    if (status == 0) {
                        self.appDelegate.showAlert(viewscontroler: self, message: "用户不存在")
                    } else if (status == 1) {
                        self.appDelegate.showAlert(viewscontroler: self, message: "密码错误")
                    } else {
                        let community = JSON(response.value!)["community"].stringValue
                        self.saveData(username: userName, community: community)
                        self.appDelegate.username = userName
                        self.appDelegate.community = community
                        self.performSegue(withIdentifier: "gotoMain", sender: self)
                    }
                }
            }
        }
        
    }
}

extension LoginViewController {
    func saveData(username: String, community : String){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext

            guard let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else {return}

            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)

            newValue.setValue(username, forKey: "username")
            newValue.setValue(community, forKey: "community")
            do {
                try context.save()
                print("saved data")
            } catch {
                print("saving error")
            }
        }
    }
}
