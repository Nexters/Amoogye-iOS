//
//  CustomTextfieldManager.swift
//  Amoogye
//
//  Created by 임수현 on 06/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import UIKit

class CustomTextfieldManager_bak {
    private var textfieldList = [CustomTextField_bak]()
    var focusedTextField: CustomTextField_bak?

    init(_ textfields: CustomTextField_bak...) {
        textfieldList.append(contentsOf: textfields)

        for textfield in textfields {
            textfield.addTarget(self, action: #selector(self.focusOutAll(except:)), for: UIControl.Event.editingDidBegin)
        }
    }

    @objc func focusOutAll(except tf: CustomTextField_bak) {
        focusedTextField = tf
        tf.focusOn()
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
