//
//  ViewController.swift
//  CrossLand
//
//  Created by Ki MNO on 2024/4/19.
//

import UIKit

class ViewController: UIViewController {
    
    let sbSettings = UIStoryboard(name: "Settings", bundle: Bundle.main)
    let sbMainForum = UIStoryboard(name: "Forum", bundle: Bundle.main)
    let sbFirstGuide = UIStoryboard(name: "FirstGuide", bundle: Bundle.main)
    let sbKeyboard = UIStoryboard(name: "Keyboard", bundle: Bundle.main)
    let sbForum = UIStoryboard(name: "Forum", bundle: Bundle.main)
    var vcSettings: UIViewController? = nil
    var vcForumMain: UIViewController? = nil
    var vcFirst: UIViewController? = nil
    var vcKeyboard: UIViewController? = nil
    var vcForumTable: UIViewController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        vcKeyboard = sbKeyboard.instantiateInitialViewController()
        //self.present(vcKeyboard!, animated: true)
        
        //vcFirst = sbFirstGuide.instantiateInitialViewController()
        //self.present(vcFirst!, animated: true)
        
        vcSettings = sbSettings.instantiateInitialViewController()
        self.present(vcSettings!, animated: true)
        vcForumMain = sbMainForum.instantiateInitialViewController()
        //self.present(vcForumMain!, animated: true)
        vcForumTable = sbForum.instantiateInitialViewController()
        //self.present(vcForumTable!, animated: true)
    }


}

