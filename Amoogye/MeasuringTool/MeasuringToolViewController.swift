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

    @IBOutlet weak var toolTableView: UITableView!
    @IBOutlet weak var basicMeasuringToolButton: UIButton!
    @IBOutlet weak var livingMeasuringToolButton: UIButton!
    @IBOutlet weak var editMeasuringToolButton: UIButton!
    @IBOutlet weak var tabIndicatorView: UIView!

    var measuringToolManager: RealmMeasuringToolManager?
    var measuringToolList: [MeasuringTool]?
    var isBasicToolSelected = true

    override func viewDidLoad() {
        super.viewDidLoad()
        toolTableView.dataSource = self
        toolTableView.delegate = self

        setupMeasuringToolTabBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        if isBasicToolSelected {
            self.measuringToolList = measuringToolManager?.getBasicMeasuringToolList()
        } else {
            self.measuringToolList = measuringToolManager?.getLivingMeasuringToolList()
        }
        self.toolTableView.reloadData()
    }

    @IBAction func clickBasicMeasuringToolButton(_ sender: UIButton) {
        if sender.isEnabled {
            activateMeasuringToolTabButton(sender)
            deactivateMeasuringToolTabButton(livingMeasuringToolButton)

            changeIndicatorPosition(to: sender)

            self.isBasicToolSelected = true
            self.editMeasuringToolButton.isHidden = true

            self.measuringToolList = measuringToolManager?.getBasicMeasuringToolList()
            self.toolTableView.reloadData()
        }
    }

    @IBAction func clickLivingMeasuringToolButton(_ sender: UIButton) {
        if sender.isEnabled {
            activateMeasuringToolTabButton(sender)
            deactivateMeasuringToolTabButton(basicMeasuringToolButton)

            changeIndicatorPosition(to: sender)

            self.isBasicToolSelected = false
            self.editMeasuringToolButton.isHidden = false

            self.measuringToolList = measuringToolManager?.getLivingMeasuringToolList()
            self.toolTableView.reloadData()
        }
    }
}

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
    }
}

extension MeasuringToolViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.measuringToolList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuringToolTableViewCell", for: indexPath) as! MeasuringToolTableViewCell
        setupCell(cell, index: indexPath.item)
        return cell
    }

    private func setupCell(_ cell: MeasuringToolTableViewCell, index: Int) {
        let measuringTool = self.measuringToolList![index]
        cell.delegate = self
        cell.separatorInset = UIEdgeInsets.zero
        cell.toolNameLabel.text = measuringTool.name
        cell.toolSubnameLabel.text = measuringTool.subname
        cell.setButtonImage(measuringTool.isOn)
        cell.onoffButton.isSelected = measuringTool.isOn
        cell.onoffButton.tag = index
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
}
