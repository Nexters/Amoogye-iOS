//
//  MeasuringToolViewController + EditButton.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension MeasuringToolViewController {
    @IBAction func clickEditMeasuringToolButton(_ sender: UIButton) {
        hideTabBar()
        self.editMeasuringToolButton.isHidden = true
        showEditButtons()

        self.selectedToolList = []

        self.isToolEdited = true
    }

    @objc func clickCloseButton(sender: UIButton!) {
        hideEditButtons()
        self.editMeasuringToolButton.isHidden = false
        showTabBar()

        self.isToolEdited = false
    }

    @objc func clickDeleteButton(sender: UIButton!) {
        hideEditButtons()
        self.editMeasuringToolButton.isHidden = false
        showTabBar()

        for item in selectedToolList! {
            measuringToolManager?.deleteMeasuringTool(item)
        }

        self.measuringToolList = measuringToolManager?.getLivingMeasuringToolList()

        self.isToolEdited = false
    }

    func setupEditButtons() {
        setupCloseButton()
        setupDeleteButton()
    }

    func hideEditButtons() {
        self.closeEditButton?.isHidden = true
        self.deleteEditButton?.isHidden = true
    }

    func showEditButtons() {
        self.closeEditButton?.isHidden = false
        self.deleteEditButton?.isHidden = false
    }

    private func setupCloseButton() {
        self.closeEditButton = UIButton()

        self.view.addSubview(self.closeEditButton)
        self.closeEditButton.setTitle("닫기", for: .normal)
        self.closeEditButton.setTitleColor(UIColor.amDarkBlueGrey, for: .normal)
        self.closeEditButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.closeEditButton.addTarget(self, action: #selector(clickCloseButton), for: .touchUpInside)

        self.closeEditButton.snp.makeConstraints {(make) -> Void in
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading).offset(16)
            make.top.equalTo(self.menuTitle.snp.bottom).offset(24)
        }
    }

    private func setupDeleteButton() {
        self.deleteEditButton = UIButton()

        self.view.addSubview(self.deleteEditButton)
        self.deleteEditButton.setTitle("삭제", for: .normal)
        self.deleteEditButton.setTitleColor(UIColor.amOrangeyRed, for: .normal)
        self.deleteEditButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.deleteEditButton.addTarget(self, action: #selector(clickDeleteButton), for: .touchUpInside)

        self.deleteEditButton.snp.makeConstraints {(make) -> Void in
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing).offset(-16)
            make.top.equalTo(self.menuTitle.snp.bottom).offset(24)
        }
    }
}
