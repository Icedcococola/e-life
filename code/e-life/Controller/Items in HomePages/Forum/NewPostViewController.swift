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
import CoreData

class NewPostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var postButton: UIButton!
    @IBOutlet var postText: UITextView!
    @IBOutlet var titleTextBox: UITextView!

    let URL = "http://elifedemo.free.idcfengye.com/Post/addpost"
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    // Mark: - Send post request to server
    @IBAction func post(_ sender: Any) {
        print(postText.text!)
        post()
    }
    
    
    func post() {
        let community = retrieveCommunity()
        let username = retrieveUsername()
        AF.request(URL, method: .post, parameters: ["article": postText.text!, "title": titleTextBox.text!, "poster": username, "community": community])
    }
}


extension NewPostViewController {
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
