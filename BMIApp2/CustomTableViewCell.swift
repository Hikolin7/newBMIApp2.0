//
//  CustomTableViewCell.swift
//  BMIApp2
//
//  Created by 七田　人比古 on 2014/12/17.
//  Copyright (c) 2014年 Shichida Hitohiko. All rights reserved.
//

import UIKit
import CoreData

class CustomTableViewCell: UITableViewCell {
   
    
    @IBOutlet weak var cellDate: UILabel!
    @IBOutlet weak var cellScoreBMI: UILabel!
    @IBOutlet weak var cellHight: UILabel!
    @IBOutlet weak var cellWeight: UILabel!
    @IBOutlet weak var cellIdealWeight: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
 
}
