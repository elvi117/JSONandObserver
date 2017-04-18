//
//  ListOfPhotosViewController.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit

protocol ScrollEventsProtocol {
    func changePictureSize(val:CGFloat)
    func endScroll(val:CGFloat)
}

class ListOfPhotosViewController: UIViewController, ScrollEventsProtocol {
    
    let tableManager = TableViewController(style: UITableViewStyle.plain)
    var tableView:UITableView?
    var topImage:UIImageView?
    var startFrame:CGRect?
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.gray
       
        self.tableManager.delegateMethod = self
        let navigationBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 90))
        
        self.downloadDataFromWebService { (ou:Bool) in
            if ou{
                DispatchQueue.main.async{
                self.tableManager.reloadInputs()
                    self.tableView?.reloadData()
                    
                }
            }
            else{
                DispatchQueue.main.async {
                    self.showAlertError()
                }
            }
        }
        
        prepareImage()
        prepareTableView()
        
        
        navigationBar.addSubview(self.topImage!)
        self.view.addSubview(navigationBar)

    }
    
    ////////////////////////////////
    //MARK: Prepare design component
    func prepareImage()  {
        self.topImage = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width/2-50, y: 60, width: 100, height: 100))
        self.topImage?.layer.masksToBounds = true
        self.topImage?.layer.cornerRadius = 50
        self.startFrame = CGRect(x: UIScreen.main.bounds.width/2-50, y: 60, width: 100, height: 100)
        
        
        let url = URL(string: "https://developer.apple.com/swift/images/swift-og.png")
        let queue = DispatchQueue(label: "imageDownloaderQuesues")
        queue.async {
            guard let data = try? Data(contentsOf: url!) else{
                return
            }
            DispatchQueue.main.async {
                self.topImage?.image = UIImage(data: data)
            }
        }
    }
    
    func prepareTableView()  {
        self.self.tableView = UITableView()
        
        self.tableView?.frame = CGRect(x: 0, y: 90, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height-140)
        
        self.tableView?.register(TableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView?.allowsSelection = false
        self.tableView?.delegate = self.tableManager
        self.tableView?.dataSource = self.tableManager
        self.tableView?.contentInset = UIEdgeInsets(top: 80, left: 0, bottom: 0, right: 0)
        self.tableView?.backgroundColor = UIColor.gray
        self.tableView?.separatorColor = UIColor.clear
        self.tableView?.rowHeight = 100
        self.view.addSubview(self.tableView!)
        

        self.tableView?.reloadData()
        
    }
    
    
    
    ////////////////////////////////
    //MARK: Zadanie 1 - resize image
    func changePictureSize(val:CGFloat) {
        
        if val > -80 && val < 0 {
            self.topImage?.frame = CGRect(x: (self.startFrame?.origin.x)!+((80+val)*0.5)/2, y: (self.startFrame?.origin.y)!-(80+val)*0.5, width: (self.startFrame?.size.width)!-(80+val)*0.5, height: (self.startFrame?.size.width)!-(80+val)*0.5)
            
            self.topImage?.layer.cornerRadius = ((self.startFrame?.size.width)!-(80+val)*0.5 )/2
        }
        else  if val > 0 {
            UIView.animate(withDuration: 0.2, animations: {
                self.topImage?.frame = CGRect(x: UIScreen.main.bounds.width/2 - 30.25, y: 20.5, width: 60.5, height: 60.5)
                self.topImage?.layer.cornerRadius = 30.25
            })
        }
        else if val < -80{
            UIView.animate(withDuration: 0.2, animations: {
                self.topImage?.frame = self.startFrame!
                self.topImage?.layer.cornerRadius = 50
            })
        }
        
    }
    
    func endScroll(val:CGFloat){
        if val > -50 && val < 0  {
            self.tableView?.setContentOffset(CGPoint.zero, animated: true)
        }
        else if val <= -50 && val > -80 {
            self.tableView?.setContentOffset(CGPoint(x: 0, y:-80), animated: true)
        }
        
        
    }


}
