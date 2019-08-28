//
//  HomeBarController.swift
//  Parotter
//
//  Created by Fan Zhang on 8/27/19.
//  Copyright © 2019 Fan Zhang. All rights reserved.
//

import UIKit

class HomeBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.items?[0].title = NSLocalizedString("Home", comment: "The home page to display the tweets streamline")
        self.tabBarController?.tabBar.items?[1].title = NSLocalizedString("Friends", comment: "The friends page to display a list of followers")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
