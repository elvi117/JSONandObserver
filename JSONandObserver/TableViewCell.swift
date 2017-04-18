//
//  TableViewCell.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    var titleLabel:UILabel?
    var cellImage:UIImageView?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.gray
        
        self.titleLabel = UILabel(frame: CGRect(x: 60, y: 5, width: UIScreen.main.bounds.width-70, height: 90))
        self.titleLabel?.numberOfLines = 0
        
        self.cellImage = UIImageView(frame: CGRect(x: 5, y: contentView.center.y, width: 50, height: 50))
        self.cellImage?.layer.masksToBounds = true
        self.cellImage?.layer.cornerRadius = 25
        
        let view = UIView(frame: CGRect(x: 5, y: 5, width: UIScreen.main.bounds.width-10, height: 90))
        view.addSubview(self.cellImage!)
        view.addSubview(self.titleLabel!)
        view.backgroundColor = UIColor.white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 5
        contentView.addSubview(view)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
