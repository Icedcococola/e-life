//
//  BulkPurchaseViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

protocol tablViewCellDelegate {
    func didTapSupport(productName: String)
}

class tableViewCell : UITableViewCell {
    
    var delegate: tablViewCellDelegate?
    
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var productName: UILabel!
    @IBOutlet var hotness: UILabel!
    @IBOutlet var support: UIButton!
    @IBAction func tapSupport(_ sender: Any) {
        delegate?.didTapSupport(productName: productName.text!)
    }
}

class BulkPurchaseViewController: UIViewController, tablViewCellDelegate {

    @IBOutlet var tableView: UITableView!
    
    var customProductArray : [[String]] = [
        ["user_icon" , "Username", "ProductName1", "200", "true"],
        ["user_icon" , "Username", "ProductName2", "200", "true"],
        ["user_icon" , "Username", "ProductName3", "200", "false"],
        ["user_icon" , "Username", "ProductName4", "200", "true"],
        ["user_icon" , "Username", "ProductName5", "200", "false"],
        ["user_icon" , "Username", "ProductName6", "200", "false"],
        ["user_icon" , "Username", "ProductName7", "200", "true"],
        ["user_icon" , "Username", "ProductName8", "200", "true"]
    ]
    var supplierProductArray : [[String]] = [
        ["user_icon", "supplier ProductName", "200"]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    func didTapSupport(productName: String) {
        for item in customProductArray {
            if (item[2] == productName) {
                let index = customProductArray.firstIndex(of: item)
                print(index!)
                customProductArray[index!][3] = String(Int(item[3])!+1);
                tableView.reloadData()
            }
        }
    }
}


// User-posted products
extension BulkPurchaseViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return customProductArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath) as! tableViewCell
        cell.delegate = self
        cell.avatar.image = UIImage(named: customProductArray[indexPath.row][0])
        cell.username.text = customProductArray[indexPath.row][1]
        cell.productName.text = customProductArray[indexPath.row][2]
        cell.hotness.text = customProductArray[indexPath.row][3]
        if (customProductArray[indexPath.row][4] == "true") {
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
        return cell
    }
}

//Supplier-posted products



