//
//  CustomTextfieldManager.swift
//  Amoogye
//
//  Created by 임수현 on 06/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import UIKit

class CustomTextfieldManager {
    private var textfieldList = [CustomTextField]()
    var focusedTextField: CustomTextField?

    init(_ textfields: CustomTextField...) {
        textfieldList.append(contentsOf: textfields)

        for textfield in textfields {
            textfield.addTarget(self, action: #selector(self.focusOutAll(except:)), for: UIControl.Event.editingDidBegin)
        }
    }

    @objc func focusOutAll(except tf: CustomTextField) {
        focusedTextField = tf
        for textfield in textfieldList {
            if textfield != tf {
                textfield.focusOut()
            }
        }
    }

    func focusOutAll() {
        focusedTextField = nil
        for textfield in textfieldList {
            textfield.focusOut()
        }
    }
}
