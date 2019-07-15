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
import CoreData


class NewCommentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var commentText: UITextView!
    @IBOutlet var commentButton: UIButton!
    
    let URL = "http://elifedemo.free.idcfengye.com/Comments/add"
    var id : String?
    override func viewDidLoad() {
        super.viewDidLoad()
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
            showAlert(message: "评论不能为空")
        } else {
            let username : String = retrieveUsername()
            let text : String = commentText.text!
            AF.request(URL, method: .post, parameters: ["message": text, "postid": id!, "username": username])
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

extension NewCommentViewController {
    func retrieveCommunity() -> String {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    if let community = result.community {
                        return community
                    }
                }
            } catch {
                print ("Error fetching data")
                return ""
            }
        }
        return ""
    }
    
    func retrieveUsername() -> String {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    if let username = result.username {
                        return username
                    }
                }
            } catch {
                print ("Error fetching data")
                return ""
            }
        }
        return ""
    }
}
