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
    
    let URL = "http://elifedemo.vipgz1.idcfengye.com/Propertynotice/findNewest"
    
    let functionalitiesImages : [UIImage] = [
        UIImage(named: "EmergencyNotification")!,
        UIImage(named: "LatestNotification")!,
        UIImage(named: "Activity")!,
        UIImage(named: "SecondRow")!,
        UIImage(named: "PostNotification")!,
        UIImage(named: "SendPost")!,
        UIImage(named: "Forum")!,
        UIImage(named: "NearMe")!,
        UIImage(named: "Shopping")!
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
        "9"
    ]
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet var EmergencyNews: UIView!
    @IBOutlet var News: UIView!
    @IBOutlet var NewsTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        responsiveDesign()
        fetchData()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
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
        AF.request(URL, method: .post, parameters: ["community": appDelegate.community]).responseJSON { (response) in if let json = response.value {
                let data = JSON(json)
                print (data)
                self.latestNotice.text = data["detail"].stringValue
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
