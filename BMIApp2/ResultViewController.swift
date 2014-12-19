//
//  ResultViewController.swift
//  BMIApp2
//
//  Created by 七田　人比古 on 2014/12/16.
//  Copyright (c) 2014年 Shichida Hitohiko. All rights reserved.
//

import UIKit
import CoreData

class ResultViewController: UIViewController {
    
    var myHight: String = ""
    var myWeight: String = ""
    
    //var myItems: [Double] = []
    //var myTimes: [NSDate] = []
    
    @IBOutlet weak var msgLabel: UILabel!
    @IBOutlet weak var BMILabel: UILabel!
    @IBOutlet weak var IdealWeightLabel: UILabel!
    
    var Hight: Double = 0.0
    var Weight: Double = 0.0
    var myBMI: Double = 0.0
    var myIdealWeight: Double = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Hight = (myHight as NSString).doubleValue / 100.0
        Weight = (myWeight as NSString).doubleValue
        myBMI = Weight / (Hight * Hight)
        var standardWeight: Double = (Hight * Hight) * 22
        var myBodyMassIndex: Double = ((Weight - standardWeight) / standardWeight) * 100
        
        myIdealWeight = standardWeight - Weight
        
        switch myBMI {
        case 0..<18:
            self.msgLabel.text = "あなたは痩せすぎです！"
        case 18..<25:
            self.msgLabel.text = "今の体を保ちましょう。"
        case 25..<30:
            self.msgLabel.text = "すこし運動をしましょう。"
        case 30..<35:
            self.msgLabel.text = "ダイエット...したら？"
        case 35..<40:
            self.msgLabel.text = "とばない豚はただの豚だ。"
        case 40..<100:
            self.msgLabel.text = "死にますよ。"
        default:
            self.msgLabel.text = "あなたは、人間ではないようです。"
        }
        
        self.BMILabel.text = "あなたの肥満度は" + NSString(format: "%.f", myBodyMassIndex) + "%"
        self.IdealWeightLabel.text = "理想体重 " + NSString(format: "%.f", standardWeight) + "kg"
        
        writeData()
    }
    
    /*
    CoreDataへのデータ書き込み
    */
    func writeData(){
        // CoreDataへの書き込み処理.
        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let myContext: NSManagedObjectContext = appDel.managedObjectContext!
        
        let myEntity: NSEntityDescription! = NSEntityDescription.entityForName("InfoStore", inManagedObjectContext: myContext)
        var newData = InfoStore(entity: myEntity, insertIntoManagedObjectContext: myContext)
        
        //newData.hight = Hight //身長
        newData.setValue(Hight,forKey:"hight")
        newData.setValue(Weight,forKey:"weight")
        newData.setValue(myBMI,forKey:"bmi")
        newData.setValue(myIdealWeight,forKey:"idealWeight")
        
        newData.date = NSDate()
        
        myContext.save(nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
