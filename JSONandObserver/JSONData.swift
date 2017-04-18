//
//  JSONData.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class JSONData: Object, Mappable {
    dynamic var albumId = 0
    dynamic var id = 0
    dynamic var title: String?
    dynamic var url:String?
    dynamic var thumbnailUrl:String?
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        albumId    <- map["albumId"]
        id         <- map["id"]
        title      <- map["title"]
        url       <- map["url"]
        thumbnailUrl  <- map["thumbnailUrl"]
        
    }
}
