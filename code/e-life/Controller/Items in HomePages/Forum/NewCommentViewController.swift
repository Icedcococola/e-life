//
//  NewCommentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/10/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SVProgressHUD


class NewCommentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var commentText: UITextView!
    @IBOutlet var commentButton: UIButton!
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Comments/add"
    var id : String?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var username = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        username = appDelegate.username
        commentButton.layer.cornerRadius = 15
        commentText.delegate = self
        commentText.text = "写写你想说的话吧！"
        commentText.textColor = .lightGray

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
    
    //Mark: - Send Request to server
    
    @IBAction func comment(_ sender: Any) {
       
        if (commentText.text!.isEmpty) {
            appDelegate.showAlert(viewcontroller: self, message: "评论不能为空")
        } else {
            let text : String = commentText.text!
            AF.request(URL, method: .post, parameters: ["message": text, "postid": id!, "username": self.username]).responseJSON { (response) in
                if (response.response?.statusCode != 200) {
                    SVProgressHUD.showError(withStatus: "下评论失败! Please Try Again!")
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
}
