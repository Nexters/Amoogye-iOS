//
//  MeasuringToolViewController + DimScreen.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension MeasuringToolViewController {
    func setupDimScreen() {
        if !isFirstExecution() {
            return
        }

        dimScreen = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        dimScreen.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.08)

        let toolInfoImage = UIImage(named: "toolInfo")
        let toolInfo = UIImageView(image: toolInfoImage)

        dimScreen!.addSubview(toolInfo)

        toolInfo.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(dimScreen.safeAreaLayoutGuide).offset(16)
            make.right.equalTo(dimScreen).offset(-44)
        }

        self.view.addSubview(dimScreen)

        dimScreen.snp.makeConstraints { (make) -> Void in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide)
        }

        dimScreen.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideDimScreen(_:))))
    }

    @objc private func hideDimScreen(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.1, animations: {
            sender.view?.backgroundColor = UIColor(red: 0 / 255.0, green: 0 / 255.0, blue: 0 / 255.0, alpha: 0.0)
        }) { (_) in
            sender.view?.isHidden = true
            self.setExecuted()
        }
    }

    private func isFirstExecution() -> Bool {
        if let firstExecution = UserDefaults.standard.value(forKey: UserDefaultKeyConstants.measuringToolFirstExecution) {
            return firstExecution as! Bool
        }

        return true
    }

    private func setExecuted() {
        UserDefaults.standard.set(false, forKey: UserDefaultKeyConstants.measuringToolFirstExecution)
    }
}
