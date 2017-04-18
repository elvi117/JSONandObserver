//
//  ObserverPatternProtocols.swift
//  JSONandObserver - iOS
//
//  Created by Lukasz Matuszczak on 18/04/2017.
//  Copyright © 2017 lm. All rights reserved.
//

import Foundation

protocol Subject {
    func registerObserver(o: Observer)
    func updateInObserver(message: Int)
}

protocol Observer {
    func getMessage(message:Int)
}
