//
//  TableViewController.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit
import RealmSwift
import Alamofire
import SDWebImage

class TableViewController: UITableViewController {

    var delegateMethod:ScrollEventsProtocol?
    let realm = try! Realm()
    var arrayOfInputs = [JSONData]()
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        self.arrayOfInputs = Array(realm.objects(JSONData.self))
        self.tableView.reloadData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reloadInputs()  {
        self.arrayOfInputs = Array(realm.objects(JSONData.self))
        self.tableView.reloadData()

    
    }
    
    /////////////////////////////////
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfInputs.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:TableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        cell.titleLabel?.text = self.arrayOfInputs[indexPath.row].title
        cell.cellImage?.sd_setImage(with: URL(string: self.arrayOfInputs[indexPath.row].thumbnailUrl!), placeholderImage: UIImage(named: "nil.png"))
        
        return cell
    }
    
    
    //MARK: Scroll view delegates
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.delegateMethod?.changePictureSize(val: scrollView.contentOffset.y)
    }
    
    override func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.delegateMethod?.endScroll(val: scrollView.contentOffset.y)
    }


}
