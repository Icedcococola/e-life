//
//  LatestNewsViewController.swift
//  e-life
//
//  Created by PalameMon on 7/5/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class CustomCell6 : UITableViewCell {
    
    @IBOutlet var photo: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var newsText: UILabel!
}

class LatestNewsViewController: UIViewController {

    let tagArray : [String] = [
        "国内", "国际", "军事", "体育", "娱乐", "财经", "科学"
    ]
    var tempNewsArray : [[String]] = [
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "国内"],
    ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "国内"],
    ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "国内"]
    ]
    var newsArray : [[String]] = [
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "国内"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "国内"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "国内"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "军事"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "体育"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "体育"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "娱乐"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "科学"],
        ["ComputerRepair", "发撒到发送到发送到发送到发撒的发人提起我们离不开", "发撒到发送到发送到发送到发撒的发人提起我们离不开摩尔斯家庭日美爆了热今天起我容嬷嬷末日额头景区门票儿童节", "财经"]
    ]
    
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // Mark: - Fetch data from server
    
}

extension LatestNewsViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tagArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.tagName.text = tagArray[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        tempNewsArray.removeAll()
        let tag = tagArray[indexPath.row]
        for news in newsArray {
            if (news[3] == tag){
                tempNewsArray.append(news)
            }
        }
        tableView.reloadData()
    }
}

extension LatestNewsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempNewsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell6
        
        cell.photo.image = UIImage(named: tempNewsArray[indexPath.row][0])
        cell.title.text = tempNewsArray[indexPath.row][1]
        cell.newsText.text = tempNewsArray[indexPath.row][2]
        return cell
    }
    
    
}
