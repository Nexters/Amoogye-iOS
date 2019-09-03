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
            showPortionInputButton()

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
            showPortionInputButton()

        case .PortionOnly:
            mode = .MeterialOnly
            onMode(sender: meterialModeButton)
            offMode(sender: portionModeButton)
            hidePortionInputButton()

        case .Both:
            mode = .MeterialOnly
            offMode(sender: portionModeButton)
            offMode(sender: plusLabel)
            hidePortionInputButton()
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

    func hidePortionInputButton() {
        UIView.animate(withDuration: 0.2, animations: ({
            self.srcPortionView.alpha  = 0
            self.dstPortionView.alpha  = 0

            self.srcQuantityView.transform = CGAffineTransform(translationX: -self.srcPortionView.frame.width, y: 0)
            self.srcMeterialView.transform = CGAffineTransform(translationX: -self.srcPortionView.frame.width, y: 0)
            self.srcFromView.transform = CGAffineTransform(translationX: -self.srcPortionView.frame.width, y: 0)

            self.dstToolView.transform = CGAffineTransform(translationX: -self.dstPortionView.frame.width, y: 0)
            self.dstToView.transform = CGAffineTransform(translationX: -self.dstPortionView.frame.width, y: 0)
        }))
    }

    func showPortionInputButton() {
        UIView.animate(withDuration: 0.2, animations: ({
            self.srcPortionView.alpha  = 1
            self.dstPortionView.alpha  = 1

            self.srcQuantityView.transform = .identity
            self.srcMeterialView.transform = .identity
            self.srcFromView.transform = .identity

            self.dstToolView.transform = .identity
            self.dstToView.transform = .identity
        }))
    }
}
