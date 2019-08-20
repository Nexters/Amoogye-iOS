//
//  CustomInputTextBoxManager.swift
//  Amoogye
//
//  Created by 임수현 on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import UIKit

class CustomInputButtonManager {
    private var inputButtonList = [CustomInputButton]()
    var selectedButton: CustomInputButton?

    init(_ list: CustomInputButton ...) {
        self.inputButtonList.append(contentsOf: list)
        for btn in list {
            btn.addTarget(self, action: #selector(self.focusOut(except:)), for: .touchUpInside)
        }
    }

    @objc func focusOut(except btn: CustomInputButton) {
        selectedButton = btn
        print("select button")
        btn.focusOn()
        for inputButton in inputButtonList {
            if inputButton != selectedButton {
                inputButton.focusOut()
            }
        }
    }

    func focusOutAll() {
        selectedButton = nil
        for inputButton in inputButtonList {
            inputButton.focusOut()
        }
    }
}
