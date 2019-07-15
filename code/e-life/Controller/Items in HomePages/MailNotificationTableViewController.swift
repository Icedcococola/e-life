//
//  MailNotificationTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class CustomCell2 : UITableViewCell{
    @IBOutlet var titleLabel: UILabel!
    
    @IBOutlet var contentText: UILabel!
}

class MailNotificationTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var notiArray : [JSON] = []
    
    let URL = "http://elifedemo.free.idcfengye.com/Activity/findAll"
    
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
       
    }

    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell2
        print(indexPath.row)
        cell.titleLabel.text = notiArray[indexPath.row]["title"].stringValue
        cell.contentText.text = notiArray[indexPath.row]["detail"].stringValue
        cell.layer.cornerRadius = 15
        return cell
    }
    
    // Mark: - Fetch data from server
    func fetchData(){
        let community = retrieveData()
        AF.request(URL, method: .post, parameters: ["community": community]).responseJSON { (response) in
            if let json = response.value{
                let noti = JSON(json).arrayValue
                self.notiArray = noti
                self.tableView.reloadData()
            }
        }
    }
}

extension MailNotificationTableViewController {
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
