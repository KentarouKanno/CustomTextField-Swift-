//
//  ViewController.swift
//  MultiTextField
//
//  Created by KentarOu on 2015/09/08.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CustomTextFieldDelegate {

    @IBOutlet weak var textField1: CustomTextField!
    @IBOutlet weak var textField2: CustomTextField!
    @IBOutlet weak var textField3: CustomTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textField1.parent = self
        
        textField2.inputType = .DatePicer
        textField2.pickerDate = NSDate(timeIntervalSinceNow: 60 * 60 * 24 * 5)
        textField2.parent = self
        
        textField3.inputType = .PickerView
        textField3.pickerDataArray = ["選択してください。","足立区","墨田区","荒川区","世田谷区","板橋区","台東区","江戸川区","千代田区","大田区","中央区","葛飾区","豊島区","北区","中野区","江東区","練馬区","品川区","文京区","渋谷区","港区","新宿区","目黒区","杉並区"]
        textField3.isClearPicker = true
        textField3.parent = self
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func selectValue(textValue: NSString, itemValue: AnyObject, inputType: InputType) {
        
        switch inputType {
            
        case .TextField :
            println("TextField")
        case .PickerView :
            println("PickerView")
        case .DatePicer :
            println("DatePicer")
        }
        
        println(textValue)
        println("\(itemValue)")
    }
}

