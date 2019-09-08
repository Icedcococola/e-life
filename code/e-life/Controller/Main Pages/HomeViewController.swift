//
//  HomeViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var collectionView: UICollectionView!
    
    @IBOutlet var latestNotice: UILabel!
    @IBOutlet var titleLabel: UILabel!
    
    let dataURL = "http://elifedemo.vipgz1.idcfengye.com/Propertynotice/findNewest"
    
    let functionalitiesImages : [UIImage] = [
        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
//        UIImage(named: "EmergencyNotification")!,
        UIImage(named: "LatestNotification")!,
        UIImage(named: "Activity")!,
        UIImage(named: "SecondRow")!,
        UIImage(named: "KuaidiFinder")!,
        UIImage(named: "SendPost")!,
        UIImage(named: "Forum")!,
        UIImage(named: "NearMe")!,
        UIImage(named: "Shopping")!,
        UIImage(named: "KuaidiNoti")!,
    ]
    let ID : [String] = [
        "1",
        "2",
        "3",
        "4",
        "5",
        "6",
        "7",
        "8",
        "9",
        "10"
    ]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var EmergencyNews: UIView!
    @IBOutlet var News: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        responsiveDesign()
        fetchData()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        leftSwipe.direction = .left
        self.view.addGestureRecognizer(leftSwipe)
    }
    
    @objc func swipeAction(swipe:UISwipeGestureRecognizer) {
        if (swipe.direction == .left) {
            //performSegue(withIdentifier: "goToRight", sender: self)
            let mainPage = self.parent?.parent as! UITabBarController
            mainPage.selectedViewController = mainPage.viewControllers![1]
            print ("going to the left")
        }
    }
    
    func responsiveDesign(){
        let screenHeight = self.view.frame.height
        if (screenHeight < 569){
             titleLabel.font = titleLabel.font.withSize(15)
        } else if (screenHeight < 668) {
            titleLabel.font = titleLabel.font.withSize(17)
        }
    }
    
    func fetchData(){
        AF.request(dataURL, method: .post, parameters: ["community": appDelegate.community]).responseJSON { (response) in
            if (response.response?.statusCode == 200) {
                if let json = response.value {
                    let data = JSON(json)
                    self.latestNotice.text = data["detail"].stringValue
                }
            } else {
                self.latestNotice.text = "加载失败！请注意您的网络！"
                self.latestNotice.textColor = .red
            }
        }
    }
    
    
    // UICollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functionalitiesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.icon.image = functionalitiesImages[indexPath.row]
        cell.icon.sizeToFit()
        cell.contentView.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = ID[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: id)
        navigationController?.pushViewController(viewController!, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenHeight = self.view.frame.height
        if (screenHeight < 569) {
            return CGSize(width: 48, height: 70)
        } else if (screenHeight < 668) {
            return CGSize(width: 58, height: 80)
        } else {
            return CGSize(width: 68, height: 86)
        }
    }
}
