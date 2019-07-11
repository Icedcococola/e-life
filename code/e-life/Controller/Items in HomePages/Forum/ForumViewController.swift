//
//  ForumViewController.swift
//  e-life
//
//  Created by PalameMon on 7/6/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class CustomCell4 : UITableViewCell {
    
    @IBOutlet var avatar: UIImageView!
    @IBOutlet var username: UILabel!
    @IBOutlet var post: UILabel!
}

class ForumViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addPostButton: UIButton!
    let postArray : [[String]] = [
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say. I don't know what to say. I don't know what to say. I don't know what to say. I don't know what to say. I don't know what to say. I don't know what to say.", "1"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "2"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "3"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "3"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "4"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "5"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "6"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "7"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "8"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "9"],
        ["ParkingPayment", "obama", "I don't know what to say. I don't know what to say.", "10"]

    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addPostButton.layer.cornerRadius = 25
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell4
        cell.avatar.image = UIImage(named: postArray[indexPath.row][0])
        cell.username.text = postArray[indexPath.row][1]
        cell.post.text = postArray[indexPath.row][2]
        cell.selectionStyle = .none
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "gotoComment") {
            let destVC = segue.destination as! CommentViewController
            destVC.id = sender as? String
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = postArray[indexPath.row][3]
        performSegue(withIdentifier: "gotoComment", sender: id)
    }
    

}
