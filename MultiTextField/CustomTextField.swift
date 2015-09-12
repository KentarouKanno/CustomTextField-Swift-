//
//  CustomTextField.swift
//  MultiTextField
//
//  Created by KentarOu on 2015/09/08.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

import Foundation
import UIKit


enum InputType {
    case TextField
    case PickerView
    case DatePicer
}

protocol CustomTextFieldDelegate {
    
    func selectValue(textValue:NSString, itemValue:AnyObject, inputType:InputType)
}

class CustomTextField: UITextField, KeyboardToolBarDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // Delegate
    var parent: CustomTextFieldDelegate!
    
    // DatePicker
    var datePicker: UIDatePicker!
    var pickerDate: NSDate {
        get {
            return itemValue as! NSDate
        }
        set(newValue) {
            itemValue = newValue
        }
    }
    
    // PikerView
    var pickerView: UIPickerView!
    var pickerDataArray: NSMutableArray = NSMutableArray()
    var isClearPicker: Bool = false
    
    var inputType: InputType = .TextField
    var toolBar: KeyboardToolBar = KeyboardToolBar()
    
    var textValue: NSString = ""
    var itemValue: AnyObject?
    
    // MARK:- initialize
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
        self.initSettings()
    }
    
    required override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.initSettings()
    }
    
    func initSettings() {
        self.textColor = UIColor(white: 0.146, alpha: 1.0)
        self.borderStyle = .RoundedRect
        toolBar.parentTextField = self
    }
    
    override func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
    
        if inputType == .TextField {
            return true
        }
        return false
    }
    
    // MARK:- TextField OverRide
    
    // inputView
    override var inputView: UIView? {
        get {
            
            let baseView: UIView = UIView()
            baseView.backgroundColor = UIColor.whiteColor()
            
            switch inputType {
            case .TextField :
                
                return super.inputView
            case .PickerView :
                self.valueForKeyPath("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
                
                pickerView = UIPickerView()
                pickerView.delegate = self
                pickerView.dataSource = self
                pickerView.showsSelectionIndicator = true
                
                if let value: AnyObject = itemValue {
                    pickerView.selectRow(itemValue!.integerValue, inComponent: 0, animated: true)
                } else {
                    itemValue = "0"
                }
                
                pickerView.delegate?.pickerView!(pickerView, didSelectRow: itemValue!.integerValue, inComponent: 0)
                
                baseView.frame = pickerView.frame;
                baseView.addSubview(pickerView)
                
                return baseView
            case .DatePicer :
                
                self.valueForKeyPath("textInputTraits")?.setValue(UIColor.clearColor(), forKey: "insertionPointColor")
                
                datePicker = UIDatePicker()
                datePicker.addTarget(self, action: "changedDateEvent:", forControlEvents: UIControlEvents.ValueChanged)
                datePicker.datePickerMode = UIDatePickerMode.Date
                
                if let itemval: AnyObject = itemValue {
                    datePicker.date = itemval as! NSDate
                }
                
                baseView.frame = datePicker.frame;
                baseView.addSubview(datePicker)
                return baseView
            }
        }
        
        set(newInset) {
            
            super.inputView = newInset
        }
    }
    
    // inputAccessoryView
    override var inputAccessoryView: UIView? {
        get {
            let keyboardBar:KeyboardToolBar = toolBar.initWithKeyboardToolBar()
            keyboardBar.parentTextField = self
            
            return keyboardBar
        }
        set(newValue) {
            self.inputAccessoryView = newValue
        }
    }
    
    // MARK:- DatePicker Event 
    
    func changedDateEvent(datePicker: UIDatePicker) {
        
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy年MM月dd日"
        let dateString: NSString = dateFormatter.stringFromDate(datePicker.date)
        
        textValue = dateString
        itemValue = datePicker.date
    }
    
    // MARK:- PickerView Delegate,DataSource
    
    // PickerView Columns Count
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // PickerView Rows Count
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataArray.count
    }
    
    // PickerView Display Value
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String {
        return pickerDataArray[row] as! String
    }
    
    // Select PickerView
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if isClearPicker && row == 0 {
            textValue = ""
        } else {
            textValue = pickerDataArray[pickerView.selectedRowInComponent(0)] as! NSString
        }
        
        itemValue = "\(row)"
    }
    
    // MARK:- KeyboardToolBarDelegate
    
    func selectValue() {
        
        switch inputType {
        case .TextField :
            textValue = self.text
            itemValue = ""
            
        case .PickerView,.DatePicer :
            self.text = textValue as String
        }
        self.parent .selectValue(textValue, itemValue: itemValue!, inputType: inputType)
    }
}
