//
//  PayViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreData

class PayViewController: UIViewController {

    @IBOutlet var payButton: UIButton!
    @IBOutlet var infoView: UIView!
    @IBOutlet var payAmount: UILabel!
    
    let URL = "http://elifedemo.free.idcfengye.com/Paid/getprice"
    let payURL = "http://elifedemo.free.idcfengye.com/Paid/havepaid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func designUI(){
        payButton.layer.cornerRadius = 10
        infoView.layer.cornerRadius = 10
    }
    
    // Mark: - Fetch payment bill from server
    func request() -> String {
        //payAmount.text = //request from server
        return payAmount.text!
    }
    
    func fetchData() {
        let username = retrieveData()
        AF.request(URL, method: .post, parameters: ["username": username, "type": "wuye"]).responseJSON { (response) in
            if let json = response.value {
                let price = JSON(json)["num"].stringValue
                print (price)
                self.payAmount.text = price + "元"
            }
        }
    }
    
    
    @IBAction func pay(_ sender: Any) {
        let username = retrieveData()
        AF.request(payURL, method: .post, parameters: ["username": username, "type": "wuye"]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                self.payAmount.text =  "0"
            }
        }
    }
    
    func loadData(){
        self.payAmount.text =  "0"
    }
    
}

extension PayViewController {
    
    func retrieveData() -> String {
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
                return ""
            }
        }
        return ""
    }
    
}

