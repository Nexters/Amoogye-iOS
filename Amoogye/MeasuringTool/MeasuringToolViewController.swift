//
//  MeasuringToolViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import SnapKit

class MeasuringToolViewController: UIViewController {

    @IBOutlet weak var menuTitle: UILabel!

    @IBOutlet weak var toolTableView: UITableView!
    @IBOutlet weak var basicMeasuringToolButton: UIButton!
    @IBOutlet weak var livingMeasuringToolButton: UIButton!
    @IBOutlet weak var tabIndicatorView: UIView!

    @IBOutlet weak var editMeasuringToolButton: UIButton!
    var closeEditButton: UIButton!
    var deleteEditButton: UIButton!

    var measuringToolManager: RealmMeasuringToolManager?
    var measuringToolList: [MeasuringTool]?
    var selectedToolList: [MeasuringTool]?

    var isBasicToolSelected = true {
        didSet {
            self.toolTableView.reloadData()
        }
    }
    var isToolEdited = false {
        didSet {
            self.toolTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        toolTableView.dataSource = self
        toolTableView.delegate = self

        self.selectedToolList = []

        setupMeasuringToolTabBar()
        setupEditButtons()
    }

    override func viewWillAppear(_ animated: Bool) {
        if isBasicToolSelected {
            self.measuringToolList = measuringToolManager?.getBasicMeasuringToolList()
        } else {
            self.measuringToolList = measuringToolManager?.getLivingMeasuringToolList()
        }

        hideEditButtons()
        self.toolTableView.reloadData()
    }

    // MARK: - Tool Tabl Bar 동작 함수
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

    // MARK: - Edit Button 동작 함수
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
}

// MARK: - Tool Tab Bar 함수
extension MeasuringToolViewController {
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
        button.setTitleColor(UIColor.amDarkBuleGrayWithOpacity(opacity: 0.3), for: .normal)
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

// MARK: - Edit 함수
extension MeasuringToolViewController {
    private func setupEditButtons() {
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

// MARK: - Table View 함수
extension MeasuringToolViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.measuringToolList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuringToolTableViewCell", for: indexPath) as! MeasuringToolTableViewCell
        let index = indexPath.item

        cell.delegate = self

        cell.separatorInset = UIEdgeInsets.zero
        cell.setup(tool: self.measuringToolList![index], index: index)

        if isToolEdited {
            cell.showEditButton()
        } else {
            cell.hideEditButton()
        }

        return cell
    }
}

extension MeasuringToolViewController: UITableViewDelegate {

}

extension MeasuringToolViewController: MeasuringToolTableViewCellDelegate {
    func didOnoffButton(_ tag: Int, isOn: Bool) {
        if var measuringTool = self.measuringToolList?[tag] {
            measuringTool.isOn = isOn
            self.measuringToolManager?.updateMeasuringTool(measuringTool)
        }
    }

    func addCellItem(index: Int) {
        guard let tool = self.measuringToolManager?.getLivingMeasuringToolList()[index] else {
            return
        }
        self.selectedToolList?.append(tool)
    }

    func removeCellItem(index: Int) {
        guard let tool = self.measuringToolManager?.getLivingMeasuringToolList()[index] else {
            return
        }

        for (index, item) in self.selectedToolList!.enumerated() {
            if tool.name == item.name {
                self.selectedToolList?.remove(at: index)
            }
        }
    }
}
