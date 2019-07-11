//
//  NewPostViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var postButton: UIButton!
    @IBOutlet var postText: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        postButton.layer.cornerRadius = 15
        postText.delegate = self
        postText.text = "写写你想说的话吧！"
        postText.textColor = .lightGray
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
    }
}
