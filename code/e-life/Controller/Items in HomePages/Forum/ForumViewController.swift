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
import CoreData

class CustomCell10 : UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var author: UILabel!
}

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addPostButton: UIButton!
    var postArray : [JSON] = []
    let URL = "http://elifedemo.free.idcfengye.com/Post/findall"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        addPostButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell10
        cell.title.text = postArray[indexPath.row]["title"].stringValue
        cell.author.text = postArray[indexPath.row]["poster"].stringValue
        cell.selectionStyle = .none
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
        let community = retrieveData()
        AF.request(URL, method: .post, parameters: ["community": community]).responseJSON { (response) in
            if let json = response.value{
                let posts = JSON(json).arrayValue
                self.postArray = posts
                self.tableView.reloadData()
            }
        }
    }
    
}


extension ForumViewController {
    func retrieveData() -> String {
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
}
