//
//  CalculatorViewController + interaction.swift
//  Amoogye
//
//  Created by 임수현 on 01/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension CalculatorViewController {

    @objc func clickMeterialButton() {
        switch mode {
        case .MeterialOnly:
            mode = .PortionOnly
            offMode(sender: meterialModeButton)
            onMode(sender: portionModeButton)

        case .PortionOnly:
            mode = .Both
            onMode(sender: meterialModeButton)
            onMode(sender: plusLabel)

        case .Both:
            mode = .PortionOnly
            offMode(sender: meterialModeButton)
            offMode(sender: plusLabel)
        }
    }

    @objc func clickPortionButton() {
        switch mode {
        case .MeterialOnly:
            mode = .Both
            onMode(sender: portionModeButton)
            onMode(sender: plusLabel)

        case .PortionOnly:
            mode = .MeterialOnly
            onMode(sender: meterialModeButton)
            offMode(sender: portionModeButton)

        case .Both:
            mode = .MeterialOnly
            offMode(sender: portionModeButton)
            offMode(sender: plusLabel)
        }
    }

    func onMode(sender: UIButton) {
        sender.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        sender.titleLabel?.font = .systemFont(ofSize: 24, weight: .bold)
    }

    func onMode(sender: UILabel) {
        sender.textColor = UIColor.amDarkBlueGrey
        sender.font = .systemFont(ofSize: 24, weight: .bold)
    }

    func offMode(sender: UIButton) {
        sender.setTitleColor(UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2), for: .normal)
        sender.titleLabel?.font = .systemFont(ofSize: 24)
    }

    func offMode(sender: UILabel) {
        sender.textColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.2)
        sender.font = .systemFont(ofSize: 24)
    }
}
