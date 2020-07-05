//
//  CustomInputButtonManager.swift
//  Amoogye
//
//  Created by 임수현 on 23/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class CustomInputButtonManager {
    var inputButtons = [CustomInputButton]()
    var focusedButton: CustomInputButton?

    init(_ buttons: CustomInputButton...) {
        inputButtons.append(contentsOf: buttons)

        for btn in buttons {
            btn.addTarget(self, action: #selector(self.focusOn(button:)), for: UIControl.Event.touchUpInside)
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

    func hasEmptyButtons() -> Bool {
        for btn in inputButtons {
            if btn.title(for: .normal) == ""{
                return true
            }
        }
        return false
    }
}
