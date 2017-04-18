//
//  MainView.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit

class MainView: UIViewController {

    var tabBar = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setTabs()
        self.view.addSubview(self.tabBar.view)
        
    }
    
    func setTabs() {
        
        let tab1 = ListOfPhotosViewController()
        let tab2 = SubjectViewController()
        let tab3 = ObserverViewController()
        
        tab2.registerObserver(o: tab3)
        
        tab1.tabBarItem.title = "List of photos"
        tab2.tabBarItem.title = "Subject"
        tab3.tabBarItem.title = "Observer"
        
        self.tabBar = UITabBarController();
        self.tabBar.viewControllers = [tab1, tab2, tab3];
        
        return
    }


}
