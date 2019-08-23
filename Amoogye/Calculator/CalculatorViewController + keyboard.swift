//
//  CalculatorViewController + keyboard.swift
//  Amoogye
//
//  Created by 임수현 on 23/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController {
    private func removeKeyboardSubviews() {
        for subview in keyboardView.subviews {
            subview.removeFromSuperview()
        }
    }

    private func addKeyboardView(keyboard view: UIView) {
        keyboardView.addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalTo(keyboardView)
        }
    }

    func showNumericKeyboard() {
        let numericKeyboard = NumericKeyboardView()
        numericKeyboard.delegate = self

        removeKeyboardSubviews()
        addKeyboardView(keyboard: numericKeyboard)
    }
}

extension CalculatorViewController: NumericKeyboardDelegate {
    func inputNumber(number newValue: String) {
        guard let focused = textFieldManager?.focusedTextField else { return }
        guard let text = focused.text else {
            focused.text = newValue
            focused.textColor = UIColor.amOrangeyRed // focused.setAsCommonText()
            return
        }

        if text == "0" || focused.textColor == UIColor.amLightBlueGrey {
            focused.text = newValue
            focused.textColor = UIColor.amOrangeyRed // focused.setAsCommonText()
            return
        }

        focused.text = text + newValue
    }

    func deleteValue() {
        guard let focused = textFieldManager?.focusedTextField, let text = focused.text else {
            return
        }

        if focused.textColor == UIColor.amLightBlueGrey {
            return
        }

        if text.count > 1 {
            let end = text.index(before: text.endIndex)
            focused.text = String(text[..<end])
            return
        }

        focused.text = focused.recentText
        focused.textColor = UIColor.amLightBlueGrey // focused.setAsPlaceHoder()
    }

    func inputDot() {
        guard let focused = textFieldManager?.focusedTextField, let text = focused.text else {
            return
        }

        if focused != srcQuantityInput {
            return
        }

        if text == "" || text == "0" {
            focused.text = "0."
            focused.textColor = UIColor.amOrangeyRed // focused.setAsCommonText()
            return
        }

        focused.text = text + "."
    }

    func getLastInputValue() -> String {
        guard let text = textFieldManager?.focusedTextField?.text else { return "" }

        if text.count > 0 {
            let lastIndex = text.index(before: text.endIndex)
            return String(text[lastIndex])
        }

        return ""
    }
}
