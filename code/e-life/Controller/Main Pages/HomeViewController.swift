//
//  HomeViewController.swift
//  e-life
//
//  Created by PalameMon on 7/1/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit
import CoreData

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
        saveData(value: "Hokhy Tann")
        saveData(value: "Leakna Chan")
        saveData(value: "Mouyly Taing")
        saveData(value: "Tumneup Tann")
        retrieveData()
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

extension HomeViewController {
    func saveData(value: String){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            
            guard let entityDescription = NSEntityDescription.entity(forEntityName: "User", in: context) else {return}
            
            let newValue = NSManagedObject(entity: entityDescription, insertInto: context)
            
            newValue.setValue(value, forKey: "username")
            
            do {
                try context.save()
                print("saved data")
            } catch {
                print("saving error")
            }
        }
    }
    
    
    func retrieveData() {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<User>(entityName: "User")
            
            do {
                let results = try context.fetch(fetchRequest)
                
                for result in results {
                    if let username = result.username {
                        print (username)
                    }
                }
            } catch {
                print ("Error fetching data")
            }
            
        }
        
        
    }
}
