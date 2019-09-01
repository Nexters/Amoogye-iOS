//
//  CalculatorViewController + keyboard.swift
//  Amoogye
//
//  Created by 임수현 on 23/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController {
    func removeKeyboardSubviews() {
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

    func showMeterialPicker() {
        let meterialPicker = MeterialPickerView()
        meterialPicker.delegate = self

        removeKeyboardSubviews()
        addKeyboardView(keyboard: meterialPicker)
    }
}
