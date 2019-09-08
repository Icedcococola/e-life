//
//  DeliveryViewController.swift
//  e-life
//
//  Created by PalameMon on 8/28/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DeliveryCustomCell : UITableViewCell{
    
    @IBOutlet var marketName: UILabel!
}

class DeliveryViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var marketsArray : [JSON] = []
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Servicea/findbytypeandcommunity"
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        // Do any additional setup after loading the view.
    }
    
    
    func fetchData() {
        AF.request(URL, method: .get, parameters: ["type": 1, "community": appDelegate.community]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                if let json = response.value{
                    let data = JSON(json).arrayValue
                    self.marketsArray = data
                    self.tableView.reloadData()
                }
            } else {
                self.appDelegate.showAlert(viewcontroller: self, message: "网络不给力")
            }
        }
    }
}

extension DeliveryViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return marketsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DeliveryCustomCell
        cell.marketName.text = marketsArray[indexPath.row]["storename"].stringValue
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "goToMarketDetails", sender: marketsArray[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToMarketDetails") {
            print (sender!)
            let destVC = segue.destination as! MarketDetailViewController
            destVC.market = sender as! JSON
        }
    }
}
