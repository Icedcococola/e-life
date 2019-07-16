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
import CoreData

class ServicesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var LatestNews: UIView!
    @IBOutlet var News: UIView!
    @IBOutlet var NewsTextView: UITextView!
    @IBOutlet var collectionView: UICollectionView!
    
    let callURL = "http://elifedemo.free.idcfengye.com/Services/find"
    
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
        designUI()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // design UI
    func designUI(){
        //set rounded corner
        let path = UIBezierPath(roundedRect: LatestNews.bounds, byRoundingCorners:[.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 30, height:  30))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        LatestNews.layer.mask = maskLayer
        
        News.layer.cornerRadius = 10
        NewsTextView.layer.cornerRadius = 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functionItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        print(cell)
        cell.icon1.image = functionItems[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let community = retrieveData()
        switch (indexPath.row){
            case 0:
                AF.request(callURL, method: .get, parameters: ["community": community, "type": "0"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        print (phonenum)
                        self.callNumber(phoneNumber: phonenum)
                    }
                }
            case 1:
                AF.request(callURL, method: .get, parameters: ["community": community, "type": "1"]).responseJSON { (response) in
                    if let json = response.value {
                        let phonenum = JSON(json)["phonenum"].stringValue
                        print (phonenum)
                        self.callNumber(phoneNumber: phonenum)
                    }
            }
            case 2:
                AF.request(callURL, method: .get, parameters: ["community": community, "type": "2"]).responseJSON { (response) in
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

extension ServicesViewController {
    
    func retrieveData() -> String {
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
                return ""
            }
        }
        return ""
    }
    
}

