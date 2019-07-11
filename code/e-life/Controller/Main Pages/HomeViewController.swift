//
//  HomeViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    

    @IBOutlet var collectionView: UICollectionView!
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
    
    @IBOutlet var EmergencyNews: UIView!
    @IBOutlet var News: UIView!
    @IBOutlet var NewsTextView: UITextView!
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
        let path = UIBezierPath(roundedRect: EmergencyNews.bounds, byRoundingCorners:[.bottomRight, .bottomLeft], cornerRadii: CGSize(width: 30, height:  30))
        
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = path.cgPath
        EmergencyNews.layer.mask = maskLayer
        
        News.layer.cornerRadius = 10
        NewsTextView.layer.cornerRadius = 10
    }
    
    // UICollectionView Delegates
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return functionalitiesImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.icon.image = functionalitiesImages[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let id = ID[indexPath.row]
        let viewController = storyboard?.instantiateViewController(withIdentifier: id)
        navigationController?.pushViewController(viewController!, animated: true)
    }

}
