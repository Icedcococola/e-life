//
//  DetailViewController.swift
//  e-life
//
//  Created by PalameMon on 7/15/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class DetailViewController: UIViewController {
    
    var id : String = ""

    @IBOutlet var image: UIImageView!
    @IBOutlet var supplier: UILabel!
    @IBOutlet var price: UILabel!
    @IBOutlet var leftAmount: UILabel!
    @IBOutlet var timer: UILabel!
    @IBOutlet var detail: UILabel!
    @IBOutlet var add: UIButton!
    @IBOutlet var buyAmount: UITextField!
    
    let URL = "http://elifedemo.free.idcfengye.com/Goods/finddetail"
    let addURL = "http://elifedemo.free.idcfengye.com/Goodsuser/add"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //fetchData()
        add.layer.cornerRadius = 10
        print (id)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    // Make request for data
    func fetchData(){
        let username = retrieveUsername()
        AF.request(URL, method: .post, parameters: ["username": username, "goodsid": id]).responseJSON { (response) in
            if let json = response.value {
                let data = JSON(json)
                let num = data["num"].stringValue
                self.supplier.text = data["store"].stringValue
                self.price.text = data["price"].stringValue
                self.leftAmount.text = data["remainingnum"].stringValue
                self.timer.text = data["deadline"].stringValue
                self.detail.text = data["detail"].stringValue
                if (num != "0"){
                    self.setBought(num: num)
                }
            }
        }
    }
    @IBAction func join(_ sender: Any) {
        let username = retrieveUsername()
        AF.request(addURL, method: .post, parameters: ["num": buyAmount.text!, "goodsid" : id, "username": username]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                self.fetchData()
            }
        }
    }
    
    func setBought(num : String) {
        buyAmount.text = num
        buyAmount.isEnabled = false
        add.backgroundColor = .lightGray
        add.setTitle("已加入", for: .disabled)
        //add.titleLabel?.text = "已加入"
        add.isEnabled = false
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
