//
//  CustomTextfieldManager.swift
//  Amoogye
//
//  Created by 임수현 on 06/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class CustomTextfieldManager {
    private var textfieldList = [CustomTextField]()

    init(_ tf1: CustomTextField, _ textfields: CustomTextField...) {
        textfieldList.append(tf1)
        textfieldList.append(contentsOf: textfields)
    }

    func focusOutAll(except tf: CustomTextField) {
        for textfield in textfieldList {
            if textfield != tf {
                textfield.focusOut()
            }
        }
    }
}
