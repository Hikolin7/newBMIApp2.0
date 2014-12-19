//
//  InfoStore.swift
//  BMIApp2
//
//  Created by 七田　人比古 on 2014/12/16.
//  Copyright (c) 2014年 Shichida Hitohiko. All rights reserved.
//

import UIKit
import CoreData

@objc(InfoStore)
class InfoStore: NSManagedObject {
    
    @NSManaged var hight:Double
    @NSManaged var weight:Double
    @NSManaged var bmi:Double
    @NSManaged var date:NSDate
}