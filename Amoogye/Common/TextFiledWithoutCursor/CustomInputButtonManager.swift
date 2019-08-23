//
//  CustomInputButtonManager.swift
//  Amoogye
//
//  Created by 임수현 on 23/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomInputButtonManager {
    private var inputButtons = [CustomInputButton]()
    var focusedButton: CustomInputButton?

    init(_ buttons: CustomInputButton...) {
        inputButtons.append(contentsOf: inputButtons)

        for textfield in buttons {
            textfield.addTarget(self, action: #selector(self.focusOn(button:)), for: UIControl.Event.editingDidBegin)
        }
    }

    @objc func focusOn(button focused: CustomInputButton) {
        focusedButton = focused
        focused.focusOn()
        for btn in inputButtons {
            if focused != btn {
                btn.focusOut()
            }
        }
    }

    func focusOutAll() {
        focusedButton = nil
        for btn in inputButtons {
            btn.focusOut()
        }
    }
}
