//
//  NewPostViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class NewPostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet var postButton: UIButton!
    @IBOutlet var postText: UITextView!
    @IBOutlet var titleTextBox: UITextView!

    let URL = "http://elifedemo.vipgz1.idcfengye.com/Post/addpost"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var username = ""
    var community = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        username = appDelegate.username
        community = appDelegate.community
        postButton.layer.cornerRadius = 15
        postText.delegate = self
        postText.text = "写写你想说的话吧！"
        postText.textColor = .lightGray
        titleTextBox.delegate = self
        titleTextBox.text = "标题！"
        titleTextBox.textColor = .lightGray
        // Do any additional setup after loading the view.
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Placeholder"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextBox.resignFirstResponder()
        postText.resignFirstResponder()
        return true
    }
    
    
    // Mark: - Send post request to server
    @IBAction func post(_ sender: Any) {
        post()
    }

    func post() {
        AF.request(URL, method: .post, parameters: ["article": postText.text!, "title": titleTextBox.text!, "poster": self.username, "community": self.community]).responseJSON { (response) in
            if (response.response?.statusCode != 200) {
                self.appDelegate.showAlert(viewscontroler: self, message: "发布失败！Please Try Again!")
            } else {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
