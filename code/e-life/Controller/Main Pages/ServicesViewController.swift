//
//  ServicesViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var collectionView: UICollectionView!
    
    let callURL = "http://elifedemo.vipgz1.idcfengye.com/Services/find"
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let functionItems : [UIImage] = [
        UIImage(named: "MarketDelivery")!,
        UIImage(named: "Maintainance")!,
        UIImage(named: "ComputerRepair")!,
        UIImage(named: "Paying")!,
        UIImage(named: "ParkingPayment")!
    ]
    let ID : [String] = [
        "1",
        "2"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.icon1.image = functionItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.row){
            case 0:
                AF.request(callURL, method: .get, parameters: ["community": self.appDelegate.community, "type": "0"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        print (phonenum)
                        self.callNumber(phoneNumber: phonenum)
                    }
                }
            case 1:
                AF.request(callURL, method: .get, parameters: ["community": self.appDelegate.community, "type": "1"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        print (phonenum)
                        self.callNumber(phoneNumber: phonenum)
                    }
            }
            case 2:
                AF.request(callURL, method: .get, parameters: ["community": self.appDelegate.community, "type": "2"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        print (phonenum)
                        self.callNumber(phoneNumber: phonenum)
                    }
            }
            default:
                let id = ID[indexPath.row-3]
                let viewController = storyboard?.instantiateViewController(withIdentifier: id)
                navigationController?.pushViewController(viewController!, animated: true)
        }
    }
    func callNumber(phoneNumber: String) {
        if let url = URL(string: "tel://\(phoneNumber)") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url as URL)
            }
        }
    }
}

