//
//  CommentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class CustomCell5 : UITableViewCell
{
    
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var comment: UILabel!
}

class CommentViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    let commentArray : [[String]] = [
        ["user_icon", "username", "comment"],
        ["user_icon", "username1", "comment1"],
        ["user_icon", "username2", "comment2"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3 comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
        ["user_icon", "username3", "comment3"],
    ]

    var id : String?
    
    @IBOutlet var addCommentButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        addCommentButton.layer.cornerRadius = 25
        print(id! as Any)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell5
        cell.avatar.image = UIImage(named: commentArray[indexPath.row][0])
        cell.username.text = commentArray[indexPath.row][1]
        cell.comment.text = commentArray[indexPath.row][2]
        cell.layer.cornerRadius = 15
        cell.selectionStyle = .none
        return cell
    }
    
    
    //Mark: - Fetch comment from server
    
    

}
