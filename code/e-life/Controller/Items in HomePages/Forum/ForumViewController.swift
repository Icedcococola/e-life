//
//  ForumViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class CustomCell10 : UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
}

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addPostButton: UIButton!
    var postArray : [JSON] = []
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Post/findall"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var community = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPostButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        community = appDelegate.community
        fetchData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell10
        cell.title.text = postArray[indexPath.row]["title"].stringValue
        cell.author.text = postArray[indexPath.row]["poster"].stringValue
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = UIColor.clear
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            cell.title.font = cell.title.font.withSize(14)
            cell.author.font = cell.author.font.withSize(10)
        } else if (screenHeight < 669) {
            cell.title.font = cell.title.font.withSize(16)
            cell.author.font = cell.author.font.withSize(12)
        } else {
            cell.title.font = cell.title.font.withSize(17)
            cell.author.font = cell.author.font.withSize(13)
        }
        
        let whiteRoundedView : UIView = UIView(frame: CGRect(x: 10, y: 3, width: self.view.frame.size.width - 20, height: 3000))
        
        whiteRoundedView.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.9])
        whiteRoundedView.layer.masksToBounds = false
        whiteRoundedView.layer.cornerRadius = 5.0
        
        cell.contentView.addSubview(whiteRoundedView)
        cell.contentView.sendSubviewToBack(whiteRoundedView)
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoComment") {
            let destVC = segue.destination as! CommentViewController
            destVC.id = sender as? String
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = postArray[indexPath.row]["postid"].stringValue
        performSegue(withIdentifier: "gotoComment", sender: id)
    }
    
    func fetchData(){
        AF.request(URL, method: .post, parameters: ["community": self.community]).responseJSON { (response) in
            if let json = response.value{
                let posts = JSON(json).arrayValue
                self.postArray = posts
                self.tableView.reloadData()
            }
        }
    }
    
}
