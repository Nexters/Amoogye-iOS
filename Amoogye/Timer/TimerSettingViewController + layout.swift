//
//  TimerSettingViewController + layout.swift
//  Amoogye
//
//  Created by 임수현 on 2020/07/06.
//  Copyright © 2020 KookKook. All rights reserved.
//

import UIKit

extension TimerSettingViewController {
    func setup() {
        hourInputView.addSubview(hourInputButton)
        minInputView.addSubview(minInputButton)
        secInputView.addSubview(secInputButton)

        inputButtonManager = CustomInputButtonManager(hourInputButton, minInputButton, secInputButton)
        inputButtonManager?.focusOn(button: hourInputButton)
        setupButtonStyle(startButton)
    }

    func setupButtonStyle(_ buttons: UIButton...) {
        for button in buttons {
            button.layer.cornerRadius = 6
        }
    }
}
