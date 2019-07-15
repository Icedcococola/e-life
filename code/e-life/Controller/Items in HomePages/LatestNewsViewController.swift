//
//  LatestNewsViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import CoreData
import SwiftyJSON
import Alamofire

class CustomCell6 : UITableViewCell {
    
    @IBOutlet var title: UILabel!
    @IBOutlet var newsText: UILabel!
}

class LatestNewsViewController: UIViewController {

    let tagArray : [String] = [
        "国内", "国际", "军事", "体育", "娱乐", "财经", "科学"
    ]
    var newsArray : [JSON] = []
     let URL = "http://elifedemo.free.idcfengye.com/Activity/findAll"
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    // Mark: - Fetch data from server
    func fetchData() {
        let community = retrieveData()
        AF.request(URL, method: .post, parameters: ["community": community]).responseJSON { (response) in
            if let json = response.value{
                let latestNewsArray = JSON(json).arrayValue
                self.newsArray = latestNewsArray
                self.tableView.reloadData()
                //activitiesArray =
            }
        }
        
    }
    
}

extension LatestNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.tagName.text = tagArray[indexPath.row]
        return cell
    }
}

extension LatestNewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell6
        
        cell.title.text = newsArray[indexPath.row]["title"].stringValue
        cell.newsText.text = newsArray[indexPath.row]["detail"].stringValue
        return cell
    }
}

extension LatestNewsViewController {
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
