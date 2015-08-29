//
//  ViewController.swift
//  Inter-App Keychain
//
//  Created by Herman Liang on 2015/8/29.
//  Copyright (c) 2015 8085 Studio. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var service = "com.8085studio.iak1"
    private var group = ""
    private let kTestKey = "TestKey"
    private var kcu: KeychainUtility?
    
    @IBOutlet var appTitle: UILabel!
    @IBOutlet var valueTextField: UITextField!
    @IBOutlet var taskInfo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let titleStr = NSBundle.mainBundle().infoDictionary!["CFBundleName"] as? String {
            appTitle.text = titleStr
        }
        
        if let appIdPrefix = NSBundle.mainBundle().infoDictionary!["AppIdentifierPrefix"] as? String {
            self.group = appIdPrefix + service
            self.kcu = KeychainUtility(service: self.service, group: self.group)
            appTitle.text = appTitle.text! + " (\(appIdPrefix))"
        } else {
            appTitle.text = appTitle.text! + " (No AppIdPrefix)"
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    @IBAction func insertClick(sender: UIButton) {
        if let data = valueTextField.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) {
            if let result = kcu?.insert(data, key: self.kTestKey) {
                if result {
                    taskInfo.text = "Insert data succeed"
                } else {
                    taskInfo.text = "Insert data failed"
                }
            } else {
                taskInfo.text = "Insert data failed"
            }
        } else {
            taskInfo.text = "Wrong data"
        }
    }
    
    @IBAction func queryClick(sender: UIButton) {
        if let data = kcu?.query(self.kTestKey) {
            taskInfo.text = NSString(data: data, encoding: NSUTF8StringEncoding) as? String
        } else {
            taskInfo.text = "No data"
        }
    }
    
    @IBAction func updateClick(sender: UIButton) {
        if let data = valueTextField.text.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true) {
            if let result = kcu?.update(data, key: self.kTestKey) {
                if result {
                    taskInfo.text = "Update data succeed"
                } else {
                    taskInfo.text = "Update data failed"
                }
            } else {
                taskInfo.text = "Update data failed"
            }
        } else {
            taskInfo.text = "Wrong data"
        }
    }
    
    @IBAction func deleteClick(sender: UIButton) {
        if let result = kcu?.deleteData(self.kTestKey) {
            if result {
                taskInfo.text = "Delete data succeed"
            } else {
                taskInfo.text = "Delete data failed"
            }
        } else {
            taskInfo.text = "Delete data failed"
        }
    }
    
    
}

