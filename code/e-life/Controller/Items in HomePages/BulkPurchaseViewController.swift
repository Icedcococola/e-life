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
import SVProgressHUD

protocol tablViewCellDelegate {
    func didTapSupport(id: String)
}

class tableViewCell : UITableViewCell {
    
    var delegate: tablViewCellDelegate?
    var id = ""
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
    @IBOutlet var titleLabel: UILabel!
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Desired/findAll"
    let URL1 = "http://elifedemo.vipgz1.idcfengye.com/Goods/findAll"
    let URL2 = "http://elifedemo.vipgz1.idcfengye.com/Desireduser/help"
    var customProductArray : [JSON] = []
    var supplierProductArray : [JSON] = []
    var haveNewProduct : Bool = false
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responsiveDesign()
        checkForNewProduct()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        fetchData()
    }
    
    func responsiveDesign() {
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            titleLabel.font = titleLabel.font.withSize(15)
        } else if (screenHeight < 669) {
            titleLabel.font = titleLabel.font.withSize(17)
        }
    }
    
    func checkForNewProduct () {
        if (haveNewProduct) {
            print ("New Product Comming")
        }
    }
    
    func didTapSupport(id : String) {
        AF.request(URL2, method: .post, parameters: ["username": self.appDelegate.username, "desiredid": id]).responseJSON { (response) in
            if response.response?.statusCode == 200 {
                AF.request(self.URL, method: .post, parameters: ["username": self.appDelegate.username, "community": self.appDelegate.community]).responseJSON { (response) in if let json = response.value{
                    let desiredArray = JSON(json).arrayValue
                    self.customProductArray = desiredArray
                    self.tableView1.reloadData()
                    }
                }
            }
        }
    }
    
    func fetchData(){
        SVProgressHUD.show(withStatus: "加载中")
        AF.request(URL, method: .post, parameters: ["username": self.appDelegate.username, "community": self.appDelegate.community]).responseJSON { (response) in
            if (response.response?.statusCode != 200) {
                SVProgressHUD.dismiss()
                self.appDelegate.showAlert(viewscontroler: self, message: "加载失败！请注意您的网络")
            } else {
                if let json = response.value{
                    SVProgressHUD.dismiss()
                    let desiredArray = JSON(json).arrayValue
                    self.customProductArray = desiredArray
                    self.tableView1.reloadData()
                }
            }
        }
        
        AF.request(URL1, method: .post, parameters: ["community": self.appDelegate.community]).responseJSON { (response) in
            print (self.appDelegate.community)
            if (response.response?.statusCode != 200) {
                SVProgressHUD.dismiss()
                self.appDelegate.showAlert(viewscontroler: self, message: "加载失败！请注意您的网络")
            } else {
                if let json = response.value {
                    SVProgressHUD.dismiss()
                    let productArray = JSON(json).arrayValue
                    self.supplierProductArray = productArray
                    print (productArray)
                    self.tableView2.reloadData()
                }
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
            } else if (customProductArray[indexPath.row]["publisher"].stringValue == self.appDelegate.username){
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
