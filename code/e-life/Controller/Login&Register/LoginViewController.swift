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
import CoreData

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
    
    var isLoggedIn : Bool = false
    
     let URL = "http://elifedemo.free.idcfengye.com/User/login"
    
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
            logoHeight.constant -= 30
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
            let parameter = ["username": userName, "password": passWord]
            AF.request(URL, method: .post, parameters: parameter).responseJSON { (response) in
                if (response.response?.statusCode != 200) {
                    self.showAlert(message: "Error! Please try again!")
                } else {
                    let status : Int = JSON(response.value)["num"].intValue
                    print (status)
                    if (status == 0) {
                        self.showAlert(message: "用户不存在")
                    } else if (status == 1) {
                        self.showAlert(message: "密码错误")
                    } else {
                        let community = JSON(response.value)["community"].stringValue
                        print (community)
                        self.saveData(username: userName, community: community)
                        self.performSegue(withIdentifier: "gotoMain", sender: self)
                    }
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


    func retrieveData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<User>(entityName: "User")

            do {
                let results = try context.fetch(fetchRequest)

                for result in results {
                    if let username = result.username {
                        print (username)
                    }
                }
            } catch {
                print ("Error fetching data")
            }

        }
    }

}
