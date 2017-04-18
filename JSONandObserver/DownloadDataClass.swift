//
//  DownloadDataClass.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 31/01/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation
import RealmSwift
import Alamofire
import AlamofireObjectMapper

extension ListOfPhotosViewController {
    
    func showAlertError() {
        let alert = UIAlertController(title: "Error", message: "Unable to download an JSON", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Reload", style: UIAlertActionStyle.default, handler: { (UIAlertAction) in
            self.downloadDataFromWebService { (ou:Bool) in
                if ou{
                    DispatchQueue.main.async{
                        self.tableManager.reloadInputs()
                    }
                }
                else{
                    DispatchQueue.main.async {
                        self.showAlertError()
                    }
                }
            }
        }))
            
            self.present(alert, animated: true, completion: nil)
    }
    
    //MARK:- download data from remote
    func downloadDataFromWebService(blockOutput:@escaping (Bool)->Void)  {
        
        let queue = DispatchQueue(label: "AlamofireQueue")
        
        let guardArray = try! Realm().objects(JSONData.self)
        if guardArray.count == 0{
            
            let URL = "https://jsonplaceholder.typicode.com/photos"
            
            Alamofire.request(URL).responseArray(queue: queue, keyPath: nil, context: nil, completionHandler: { (response: DataResponse<[JSONData]>) in
                
                
                if let responseArray = response.result.value{
                
                
                //save data to Realm
                    let subQueue = DispatchQueue(label: "subAlamofire")
                    subQueue.async{
                        let realm = try! Realm()
                for i in responseArray{
                    try! realm.write {
                        realm.add(i)
                    }
                }
                        blockOutput(true)}
                }
                else{
                    blockOutput(false)
                }
            })
            
        }
    }
}


