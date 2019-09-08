//
//  CommentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire


class CustomCell5 : UITableViewCell
{
    @IBOutlet var username: UILabel!
    @IBOutlet var comment: UILabel!
}

class CommentViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var postDeatil : [JSON] = []
    var commentArray : [JSON] = []
    let commentURL = "http://elifedemo.vipgz1.idcfengye.com/Comments/findbyid"
    let postURL = "http://elifedemo.vipgz1.idcfengye.com/Post/findbyid"
    var id : String?
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    @IBOutlet var addCommentButton: UIButton!
    @IBOutlet var postArticle: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.sendSubviewToBack(detailView)
        addCommentButton.layer.cornerRadius = 25
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commentArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell5
        cell.username.text = commentArray[indexPath.row]["username"].stringValue
        cell.comment.text = commentArray[indexPath.row]["message"].stringValue
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            cell.username.font = cell.username.font.withSize(14)
            cell.comment.font = cell.comment.font.withSize(13)
        } else if (screenHeight < 669) {
            cell.username.font = cell.username.font.withSize(15)
            cell.comment.font = cell.comment.font.withSize(13)
        } else {
            cell.username.font = cell.username.font.withSize(15)
            cell.comment.font = cell.comment.font.withSize(13)
        }
        cell.layer.cornerRadius = 15
        cell.selectionStyle = .none
        return cell
    }
    
    @IBAction func newComment(_ sender: Any) {
        performSegue(withIdentifier: "gotoNewComment", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoNewComment") {
            let destVC = segue.destination as! NewCommentViewController
            destVC.id = id
        }
    }
    
    
    //Mark: - Fetch comment from server
    func fetchData(){
        AF.request(commentURL, method: .post, parameters: ["postid": id]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                if let json = response.value{
                    let comments = JSON(json).arrayValue
                    self.commentArray = comments
                    self.tableView.reloadData()
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "加载失败！请注意您的网络！")
            }
        }
        
        AF.request(postURL, method: .post, parameters: ["postid": id]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                if let json = response.value{
                    let postsDetail = JSON(json)
                    //self.postDeatil = postsDetail
                    self.postArticle.text = postsDetail["article"].stringValue
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "加载失败！请注意您的网络！")
            }
        }
    }
}
