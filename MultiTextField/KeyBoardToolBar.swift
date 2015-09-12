//
//  KeyBoardToolBar.swift
//  MultiTextField
//
//  Created by KentarOu on 2015/09/08.
//  Copyright (c) 2015年 KentarOu. All rights reserved.
//

import Foundation
import UIKit


protocol KeyboardToolBarDelegate {
    func selectValue()
}

class KeyboardToolBar: UIToolbar {
    
    var parentTextField: KeyboardToolBarDelegate!
    
    func initWithKeyboardToolBar() -> KeyboardToolBar {
        let toolBar: KeyboardToolBar = UINib(nibName: "KeyBoardToolBar", bundle: nil).instantiateWithOwner(self, options: nil)[0] as! KeyboardToolBar
        toolBar.barStyle = .Default
        toolBar.sizeToFit()
        return toolBar
    }
    
    // Close KeyBoard
    @IBAction func cancelButton(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().delegate?.window??.endEditing(true)
    }
    
    @IBAction func doneButton(sender: UIBarButtonItem) {
        
        if let delegate = parentTextField {
            delegate.selectValue()
        }
        self.cancelButton(UIBarButtonItem())
    }
}
