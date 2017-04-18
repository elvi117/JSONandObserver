//
//  ObserverViewController.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 18/04/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit
import SnapKit
class ObserverViewController: UIViewController, Observer {
    
    let titleLabel:UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints({ (make) -> Void in
            
            make.center.equalTo(self.view)
        
        })

        self.titleLabel.font = UIFont.systemFont(ofSize: 24)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMessage(message:Int){
        self.titleLabel.text = "I also like \(message)"
    }


}
