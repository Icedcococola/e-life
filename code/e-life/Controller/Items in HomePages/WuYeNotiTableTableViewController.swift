//
//  WuYeNotiTableTableViewController.swift
//  e-life
//
//  Created by PalameMon on 7/2/19.
//  Copyright © 2019 PalameMon. All rights reserved.
//

import UIKit

class CustomCell1 : UITableViewCell {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var contentText: UILabel!
}

class WuYeNotiTableTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    let notiArray : [[String]] = [
        ["title", "contentfadsfasdfadsfadsfadsfadsfadsfadsfjkljfkadjfladjsflkdasjfdajfiewjfkd"],
        ["title1", "contentfadsfasdfadsfadsfadsfadsfadsfadsfjkljfkadjfladjsflkdasjfdajfiewjfkd fadskjfaisfjd kfjadakldsjfaksdlfa.f"],
        ["title2", "contentfadsfasdfadsfadsfadsfadsfadsfadsfjkljfkadjfladjsflkdasjfdajfiewjfkd fadskjfaisfjd kfjadakldsjfaksdlfa.f adfkjadslkfjafafd. dsifjwefn vdaskfjasdfkmasdf. iNdsak dsafajkfel2"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }

    // MARK: - Table view data source

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notiArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell1
        cell.titleLabel.text = notiArray[indexPath.row][0]
        cell.contentText.text = notiArray[indexPath.row][1]
        cell.layer.cornerRadius = 15
        return cell

    }
    
    // Mark: - Fetch data from server
}
