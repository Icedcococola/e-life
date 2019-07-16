//
//  BulkPurchaseViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

protocol tablViewCellDelegate {
    func didTapSupport(id: String)
}

class tableViewCell : UITableViewCell {
    
    var delegate: tablViewCellDelegate?
    var id = ""
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var hotness: UILabel!
    @IBOutlet var support: UIButton!
    @IBAction func tapSupport(_ sender: Any) {
        delegate?.didTapSupport(id : id)
    }
}

class tableViewCell2 : UITableViewCell {
    
    @IBOutlet var productName: UILabel!
    @IBOutlet var timer: UILabel!
    @IBOutlet var participants: UILabel!
    @IBOutlet var price: UILabel!
    var id = ""
}

class BulkPurchaseViewController: UIViewController, tablViewCellDelegate {
    @IBOutlet var tableView1: UITableView!
    @IBOutlet var tableView2: UITableView!
    let URL = "http://elifedemo.free.idcfengye.com/Desired/findAll"
    let URL1 = "http://elifedemo.free.idcfengye.com/Goods/findAll"
    let URL2 = "http://elifedemo.free.idcfengye.com/Desireduser/help"
    var customProductArray : [JSON] = []
    var supplierProductArray : [JSON] = []
    var haveNewProduct : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        checkForNewProduct()
        // Do any additional setup after loading the view.
    }
    
    func checkForNewProduct () {
        if (haveNewProduct) {
            print ("New Product Comming")
        }
    }
    
    func didTapSupport(id : String) {
        print (id)
        AF.request(URL2, method: .post, parameters: ["username": retrieveUsername(), "desiredid": id]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                let username = self.retrieveUsername()
                let community = self.retrieveCommunity()
                AF.request(self.URL, method: .post, parameters: ["username": username, "community": community]).responseJSON { (response) in if let json = response.value{
                    let desiredArray = JSON(json).arrayValue
                    self.customProductArray = desiredArray
                    self.tableView1.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchData(){
        let username = retrieveUsername()
        let community = retrieveCommunity()
        AF.request(URL, method: .post, parameters: ["username": username, "community": community]).responseJSON { (response) in if let json = response.value{
            let desiredArray = JSON(json).arrayValue
            self.customProductArray = desiredArray
            self.tableView1.reloadData()
            }
        }
        
        AF.request(URL1, method: .post, parameters: ["community": community]).responseJSON { (response) in
            if let json = response.value {
                let productArray = JSON(json).arrayValue
                self.supplierProductArray = productArray
                self.tableView2.reloadData()
            }
        }
        
    }
    
}


// User-posted products
extension BulkPurchaseViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count : Int?
        if (tableView == tableView1) {
            count = customProductArray.count
        } else if (tableView == tableView2) {
            count = supplierProductArray.count
        }
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cellToReturn = UITableViewCell()
        if (tableView == tableView1) {
            let cell = tableView1.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! tableViewCell
            cell.delegate = self
            cell.id = customProductArray[indexPath.row]["desiredid"].stringValue
            cell.username.text = customProductArray[indexPath.row]["publisher"].stringValue
            cell.productName.text = customProductArray[indexPath.row]["goods"].stringValue
            cell.hotness.text = customProductArray[indexPath.row]["heat"].stringValue
            if (customProductArray[indexPath.row]["ishelped"].stringValue == "1") {
                cell.support.isEnabled = false
                cell.support.backgroundColor = .lightGray
                cell.support.titleLabel!.text = "Supported"
            } else {
                cell.support.isEnabled = true
                cell.support.backgroundColor = UIColor(red: 196/255, green: 240/255, blue: 255/255, alpha: 1)
                cell.support.titleLabel!.text = "Support"
                cell.support.titleLabel?.textColor = UIColor(red: 0/255, green: 143/255, blue: 191/255, alpha: 1)
            }
            cell.selectionStyle = .none
            cellToReturn = cell
        } else if (tableView == tableView2) {
            let cell = tableView2.dequeueReusableCell(withIdentifier: "secondCell", for: indexPath) as! tableViewCell2
            cell.id = supplierProductArray[indexPath.row]["goodsid"].stringValue
            cell.productName.text = supplierProductArray[indexPath.row]["goodsname"].stringValue
            cell.participants.text = supplierProductArray[indexPath.row]["remainingnum"].stringValue
            cell.timer.text = supplierProductArray[indexPath.row]["deadline"].stringValue
            cell.price.text = supplierProductArray[indexPath.row]["price"].stringValue
            cellToReturn = cell
        }
        return cellToReturn
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == tableView2){
            let cell = tableView2.cellForRow(at: indexPath) as! tableViewCell2
            let id = cell.id
            performSegue(withIdentifier: "gotoDetail", sender: id)
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoDetail"){
            let destVC = segue.destination as! DetailViewController
            destVC.id = sender as! String
        }
    }
}

extension BulkPurchaseViewController {
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




//Supplier-posted products
//supplier
//countdown
//leftAmount
//price
//detail

