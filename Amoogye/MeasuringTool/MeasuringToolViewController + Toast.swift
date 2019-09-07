//
//  MeasuringToolViewController + Toast.swift
//  Amoogye
//
//  Created by JunHui Kim on 07/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

extension MeasuringToolViewController {
    func showToast(message: String) {
        let toastLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        setupToast(toastLabel: toastLabel, message: message)
        self.view.addSubview(toastLabel)

        toastLabel.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-12)
            make.centerX.equalTo(self.view)
            make.width.equalTo(208)
            make.height.equalTo(36)
        }

        UIView.animate(
            withDuration: 1.0, delay: 0.5, animations: {
                toastLabel.alpha = 0.0
        }, completion: { (_) in
                toastLabel.removeFromSuperview()
        })
    }

    private func setupToast(toastLabel: UILabel, message: String) {
        toastLabel.backgroundColor = UIColor(displayP3Red: 77.0/255.0, green: 86.0/255.0, blue: 107.0/255.0, alpha: 0.9)
        toastLabel.font = UIFont.systemFont(ofSize: 12)
        toastLabel.textColor = UIColor.white
        toastLabel.textAlignment = .center
        toastLabel.text = message
        toastLabel.layer.cornerRadius = 6
        toastLabel.clipsToBounds = true
    }

    func checkIsToast() -> Bool {
        for tool in self.measuringToolList ?? [] {
            if tool.isEditable == true {
                return false
            }
        }
        return true
    }
}
