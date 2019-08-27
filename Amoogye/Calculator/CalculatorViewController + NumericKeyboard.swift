//
//  CalculatorViewController + NumericKeyboard.swift
//  Amoogye
//
//  Created by 임수현 on 26/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let focused = inputManager?.focusedButton else { return }
        guard let text = focused.title(for: .normal) else {
            focused.setTitle(newValue, for: .normal)
            focused.setTitleColor(UIColor.amOrangeyRed, for: .normal)
            return
        }

        if text == "0" || focused.titleColor(for: .normal) == UIColor.amLightBlueGrey {
            focused.setTitle(newValue, for: .normal)
            focused.setTitleColor(UIColor.amOrangeyRed, for: .normal)
            return
        }

        focused.setTitle(text + newValue, for: .normal)
    }

    func deleteValue() {
        guard let focused = inputManager?.focusedButton, let text = focused.title(for: .normal) else {
            return
        }

        if focused.titleColor(for: .normal) == UIColor.amLightBlueGrey {
            return
        }

        if text.count > 1 {
            let end = text.index(before: text.endIndex)
            focused.setTitle(String(text[..<end]), for: .normal)
            return
        }

        focused.setTitle(focused.recentText, for: .normal)
        focused.setAsPlaceholder()
    }

    func inputDot() {
        guard let focused = inputManager?.focusedButton else {
            return
        }

        if focused != srcQuantityInput {
            return
        }

        focused.setTitleColor(UIColor.amOrangeyRed, for: .normal)
        guard let text = focused.title(for: .normal) else {
            focused.setTitle("0.", for: .normal)
            return
        }

        if text == "" || text == "0" {
            focused.setTitle("0.", for: .normal)
            return
        }

        focused.setTitle(text + ".", for: .normal)
    }

    func getLastInputValue() -> String {
        guard let text = inputManager?.focusedButton?.title(for: .normal) else { return "" }

        if text.count > 0 {
            let lastIndex = text.index(before: text.endIndex)
            return String(text[lastIndex])
        }

        return ""
    }
}
