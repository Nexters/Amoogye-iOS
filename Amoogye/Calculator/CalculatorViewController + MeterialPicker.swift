//
//  CalculatorViewController + MeterialPicker.swift
//  Amoogye
//
//  Created by 임수현 on 01/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController: MeterialPickerDelegate {
    func selectMeterial(name: String) {
        guard let focused = inputManager?.focusedButton else {
            return
        }
        focused.setTitle(name, for: .normal)
        focused.setTitleColor(UIColor.amOrangeyRed, for: .normal)
    }

    func openMeterialSearchView() {
        searchView.isHidden = false
    }

    func closeMeterialSearchView() {
        searchView.isHidden = true

    }
}
