//
//  TVCSettings.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/19.
//

import UIKit

var prefSettingsHideDeveloperSettings = true

@IBDesignable class TVCSettings: UITableViewController {

    @IBOutlet weak var lbLogin: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == tableView.numberOfSections - 1 && prefSettingsHideDeveloperSettings {
            cell.isHidden = true
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == tableView.numberOfSections - 1 && prefSettingsHideDeveloperSettings {
            return 0
        } else {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == tableView.numberOfSections - 1 && prefSettingsHideDeveloperSettings {
            return 0
        } else {
            return super.tableView(tableView, heightForHeaderInSection: section)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if section == tableView.numberOfSections - 1 && prefSettingsHideDeveloperSettings {
            return 0
        } else {
            return super.tableView(tableView, heightForFooterInSection: section)
        }
    }

    

    @IBAction func switchPresentDebugView(_ sender: Any) {
        print("toggled!")
    }
}
