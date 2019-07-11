//
//  NewCommentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/10/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class NewCommentViewController: UIViewController, UITextViewDelegate {

    @IBOutlet var commentText: UITextView!
    @IBOutlet var commentButton: UIButton!
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
        print(commentText.text!)
    }
}
