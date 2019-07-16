//
//  FriendRequestViewController.swift
//  e-life
//
//  Created by PalameMon on 7/16/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

protocol friendTableDelegate {
    func didTappedAccept(id : String)
    func didTappedReject(id : String)
}

class CustomCell8 : UITableViewCell {
    
    var id = ""
    var delegate : friendTableDelegate?
    @IBOutlet var username: UILabel!
    @IBAction func accept(_ sender: Any) {
        delegate?.didTappedAccept(id : id)
    }
    @IBAction func reject(_ sender: Any) {
        delegate?.didTappedReject(id : id)
    }
}

class FriendRequestViewController: UIViewController, friendTableDelegate {
    func didTappedAccept(id : String) {
        print ("Accpet" + id)
    }
    
    func didTappedReject(id : String) {
        print ("Reject" + id)
    }
    

    @IBOutlet var tableView: UITableView!
    @IBOutlet var username: UITableView!
    
    let friendRequestArray = [["User1"], ["User2"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
    }
    
    
}


extension FriendRequestViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friendRequestArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell8
        cell.id = String(indexPath.row)
        cell.delegate = self
        cell.selectionStyle = .none
        cell.username.text = friendRequestArray[indexPath.row][0]
        return cell
    }
    
    
}
