//
//  CustomInputTextBoxManager.swift
//  Amoogye
//
//  Created by 임수현 on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import UIKit

class CustomInputTextBoxManager {
    private var inputBoxList = [CustomInputTextBox]()
    var selectedBox: CustomInputTextBox?

    init(_ list: [CustomInputTextBox]) {
        self.inputBoxList.append(contentsOf: list)
        for box in list {
            box.button.addTarget(self, action: #selector(self.focusOut(except: )), for: UIControl.Event.touchDown)
        }
    }

    @objc func focusOut(except box: CustomInputTextBox) {
        selectedBox = box
        box.focusOn()
        for inputBox in inputBoxList {
            if inputBox != selectedBox {
                inputBox.focusOut()
            }
        }
    }

    func focusOutAll() {
        selectedBox = nil
        for inputBox in inputBoxList {
            inputBox.focusOut()
        }
    }
}
