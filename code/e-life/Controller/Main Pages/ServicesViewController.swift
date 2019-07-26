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
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(leftSwipeAction(swipe:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(rightSwipeAction(swipe:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        self.view.addGestureRecognizer(leftSwipe)
        self.view.addGestureRecognizer(rightSwipe)
    }
    
    @objc func leftSwipeAction(swipe:UISwipeGestureRecognizer) {
        if (swipe.direction == .left) {
            let mainPage = self.parent?.parent as! UITabBarController
            mainPage.selectedViewController = mainPage.viewControllers![2]
            print ("going to the left")
        }
    }
    @objc func rightSwipeAction(swipe:UISwipeGestureRecognizer) {
        if (swipe.direction == .right) {
            let mainPage = self.parent?.parent as! UITabBarController
            mainPage.selectedViewController = mainPage.viewControllers![0]
            print ("going to the left")
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        cell.icon1.image = functionItems[indexPath.row]
        cell.icon1.sizeToFit()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch (indexPath.row){
            case 0:
                AF.request(callURL, method: .get, parameters: ["community": self.appDelegate.community, "type": "0"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        self.callNumber(phoneNumber: phonenum)
                    }
                }
            case 1:
                AF.request(callURL, method: .get, parameters: ["community": self.appDelegate.community, "type": "1"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        self.callNumber(phoneNumber: phonenum)
                    }
            }
            case 2:
                AF.request(callURL, method: .get, parameters: ["community": self.appDelegate.community, "type": "2"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
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

extension ServicesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            return CGSize(width: 48, height: 70)
        } else if (screenHeight < 669) {
            return CGSize(width: 67, height: 76)
        } else if (screenHeight < 717) {
            return CGSize(width: 72, height: 76)
        } else {
            return CGSize(width: 68, height: 86)
        }
    }
}


