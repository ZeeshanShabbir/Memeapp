//
//  TextFieldDelegate.swift
//  MemeApp
//
//  Created by Muhammad Zeeshan Shabbir on 3/8/17.
//  Copyright © 2017 Muhammad Zeeshan Shabbir. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let text = textField.text?.lowercased()
        if (text?.contains("top"))!{
            textField.text = ""
        } else if (text?.contains("bottom"))!{
            textField.text = ""
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}
