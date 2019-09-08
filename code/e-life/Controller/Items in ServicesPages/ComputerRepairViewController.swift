//
//  ComputerRepairViewController.swift
//  e-life
//
//  Created by PalameMon on 8/28/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class ComputerCustomCell : UITableViewCell {
    
    @IBOutlet var shopName: UILabel!
}

class PriceListCell : UITableViewCell {
    
    @IBOutlet var item: UILabel!
    @IBOutlet var price: UILabel!
}

class ComputerRepairViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var tableView1: UITableView!
    
    var shopName : [JSON] = []
    var priceList : [JSON] = []
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Servicea/findbytypeandcommunity"
    let URL1 = "http://elifedemo.vipgz1.idcfengye.com/Servicea/findallprice"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    func fetchData(){
        AF.request(URL, method: .get, parameters: ["type": 2, "community": appDelegate.community]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                if let json = response.value{
                    let data = JSON(json).arrayValue
                    self.shopName = data
                    self.tableView.reloadData()
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "网络不给力")
            }
        }
        AF.request(URL1, method: .get, parameters: ["community": appDelegate.community]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                if let json = response.value{
                    let data = JSON(json).arrayValue
                    self.priceList = data
                    self.tableView1.reloadData()
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "网络不给力")
            }
        }
    }
}

extension ComputerRepairViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == self.tableView) {
            return shopName.count
        } else {
            return priceList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == self.tableView) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ComputerCustomCell
            cell.shopName.text = shopName[indexPath.row]["storename"].stringValue
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell1", for: indexPath) as! PriceListCell
            cell.item.text = priceList[indexPath.row]["xiangmu"].stringValue
            cell.price.text = priceList[indexPath.row]["price"].stringValue
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (tableView == self.tableView) {
            performSegue(withIdentifier: "goToComputerShopDetails", sender: shopName[indexPath.row])
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToComputerShopDetails") {
            let destVC = segue.destination as! ComputerDetailsViewController
            destVC.shop = sender as! JSON
        }
    }
}
