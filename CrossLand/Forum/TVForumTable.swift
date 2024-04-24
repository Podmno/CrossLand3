//
//  TVForumTable.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/22.
//

import UIKit

class TVCForumTable: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupButton", for: indexPath)
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }



}


class TVButtonCellGroup: UITableViewCell {
    

    @IBOutlet weak var btnDoPost: ZFRippleButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if #available(macCatalyst 15.0,iOS 15.0, *) {
            //btnDoPost.titleLabel?.textColor = UIColor.tintColor
        } else {
            // Fallback on earlier versions
        }
    }
    var statusNotice = false
    @IBAction func btnNotice(_ sender: TRRippleButton) {
        statusNotice = !statusNotice
        sender.active(statusNotice)
    }
    
    var statusPost = false
    @IBAction func btnPost(_ sender: TRRippleButton) {
        statusPost = !statusPost
        sender.active(statusPost)
    }
    
}
