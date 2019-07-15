//
//  ParkingPaymentViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import CoreData
import SwiftyJSON

class ParkingPaymentViewController: UIViewController {

    @IBOutlet var infoView: UIView!
    @IBOutlet var paymentAmount: UILabel!
    @IBOutlet var payButton: UIButton!
    
    let URL = "http://elifedemo.free.idcfengye.com/Paid/getprice"
    let payURL = "http://elifedemo.free.idcfengye.com/Paid/havepaid"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designUI()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func designUI(){
        infoView.layer.cornerRadius = 10
        payButton.layer.cornerRadius = 10
    }

    func fetchData() {
        let username = retrieveData()
        AF.request(URL, method: .post, parameters: ["username": username, "type": "tingche"]).responseJSON { (response) in
            if let json = response.value {
                let price = JSON(json)["num"].stringValue
                print (price)
                self.paymentAmount.text = price + "元"
            }
        }
    }
    @IBAction func pay(_ sender: Any) {
        let username = retrieveData()
        AF.request(payURL, method: .post, parameters: ["username": username, "type": "tingche"]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                self.paymentAmount.text =  "0"
            }
        }
    }
}


extension ParkingPaymentViewController {
    
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
