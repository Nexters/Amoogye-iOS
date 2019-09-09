//
//  MeasuringToolViewController + ToolTabBar.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension MeasuringToolViewController {
    @IBAction func clickBasicMeasuringToolButton(_ sender: UIButton) {
        if sender.isEnabled {
            activateMeasuringToolTabButton(sender)
            deactivateMeasuringToolTabButton(livingMeasuringToolButton)
            
            changeIndicatorPosition(to: sender)
            self.editMeasuringToolButton.isHidden = true
            self.measuringToolList = measuringToolManager?.getBasicMeasuringToolList()
            
            self.isBasicToolSelected = true
        }
    }
    
    @IBAction func clickLivingMeasuringToolButton(_ sender: UIButton) {
        if sender.isEnabled {
            activateMeasuringToolTabButton(sender)
            deactivateMeasuringToolTabButton(basicMeasuringToolButton)
            
            changeIndicatorPosition(to: sender)
            self.editMeasuringToolButton.isHidden = false
            self.measuringToolList = measuringToolManager?.getLivingMeasuringToolList()
            
            self.isBasicToolSelected = false
        }
    }
    
    func setupMeasuringToolTabBar() {
        activateMeasuringToolTabButton(basicMeasuringToolButton)
        deactivateMeasuringToolTabButton(livingMeasuringToolButton)

        editMeasuringToolButton.isHidden = true

        self.tabIndicatorView.snp.makeConstraints {(make) -> Void in
            make.height.equalTo(1)
            make.top.equalTo(basicMeasuringToolButton.snp.bottom).offset(8)
            make.leading.equalTo(basicMeasuringToolButton.snp.leading).offset(0)
            make.trailing.equalTo(basicMeasuringToolButton.snp.trailing).offset(0)
        }
    }

    func activateMeasuringToolTabButton(_ button: UIButton) {
        button.setTitleColor(UIColor.amOrangeyRed, for: .normal)
        button.isEnabled = false
    }

    func deactivateMeasuringToolTabButton(_ button: UIButton) {
        button.setTitleColor(UIColor.amDarkBlueGreyWithOpacity(opacity: 0.3), for: .normal)
        button.isEnabled = true
    }

    func changeIndicatorPosition(to button: UIButton) {
        self.tabIndicatorView.snp.remakeConstraints {(make) -> Void in
            make.width.equalTo(button.snp.width)
            make.height.equalTo(1)
            make.top.equalTo(button.snp.bottom).offset(8)
            make.centerX.equalTo(button.snp.centerX).offset(0)
        }

        UIView.animate(withDuration: 0.1, animations: {
            self.view.layoutIfNeeded()
        })
    }

    func hideTabBar() {
        self.basicMeasuringToolButton.isHidden = true
        self.livingMeasuringToolButton.isHidden = true
        self.tabIndicatorView.isHidden = true
    }

    func showTabBar() {
        self.basicMeasuringToolButton.isHidden = false
        self.livingMeasuringToolButton.isHidden = false
        self.tabIndicatorView.isHidden = false
    }
}
