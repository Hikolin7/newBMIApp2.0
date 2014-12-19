//
//  AddViewController.swift
//  BMIApp2
//
//  Created by 七田　人比古 on 2014/12/16.
//  Copyright (c) 2014年 Shichida Hitohiko. All rights reserved.
//

import UIKit

class AddViewController: UIViewController {
    
    @IBOutlet weak var textFieldHight: UITextField!
    @IBOutlet weak var textFieldWeight: UITextField!
    @IBAction func onTap(sender: UITapGestureRecognizer) {
        self.view.endEditing(true) //タップでキーボードを閉じる
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.textFieldHight.text = ""
        self.textFieldWeight.text = ""
        //戻った時に、テキストフィールドの中を空に
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showAlert() {
        let VERSION: Float = (UIDevice.currentDevice().systemVersion as NSString).floatValue
        if VERSION >= 8.0 {
            let alertController = UIAlertController(title: "Error", message: "身長と体重を入力してください。", preferredStyle: .Alert)
            let defaultAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
            alertController.addAction(defaultAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        } else {
            let alert = UIAlertView()
            alert.title = "Error"
            alert.message = "身長と体重を入力してください。"
            alert.addButtonWithTitle("OK")
            alert.show()
        }
    }
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String?, sender: AnyObject?) -> Bool {
        if identifier == "showResult" {
            if self.textFieldHight.text == "" {
                self.showAlert()
                return false
            } else if self.textFieldWeight.text == "" {
                self.showAlert()
                return false
            }
            return true
        }
        return true
        //テキストフィールドが空の場合、次の画面にいかない。
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showResult" {
            let resultViewController: ResultViewController = segue.destinationViewController as ResultViewController
            resultViewController.myHight = self.textFieldHight.text
            resultViewController.myWeight = self.textFieldWeight.text
            //テキストフィールドの値を、ResultViewControllerへ
            
            self.textFieldHight.resignFirstResponder()
            self.textFieldWeight.resignFirstResponder()
            //戻ってきた時にテキストフィールドの選択をはずす
        }
    }
    
}