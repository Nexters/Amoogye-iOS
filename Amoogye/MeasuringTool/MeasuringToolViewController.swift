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

    var measuringToolManager: RMMeasuringToolManager?
    var measuringToolList: [MeasuringTool]?

    override func viewDidLoad() {
        super.viewDidLoad()
        toolTableView.dataSource = self
        toolTableView.delegate = self

        measuringToolList = measuringToolManager?.getMeausringToolList()

        setupMeasuringToolTabBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        self.measuringToolList = self.measuringToolManager?.getMeausringToolList()
        self.toolTableView.reloadData()
    }

    @IBAction func clickBasicMeasuringToolButton(_ sender: UIButton) {
        if sender.isEnabled {
            activateMeasuringToolTabButton(sender)
            deactivateMeasuringToolTabButton(livingMeasuringToolButton)

            changeIndicatorPosition(to: sender)

            editMeasuringToolButton.isHidden = true
        }
    }

    @IBAction func clickLivingMeasuringToolButton(_ sender: UIButton) {
        if sender.isEnabled {
            activateMeasuringToolTabButton(sender)
            deactivateMeasuringToolTabButton(basicMeasuringToolButton)

            changeIndicatorPosition(to: sender)

            editMeasuringToolButton.isHidden = false
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
        return measuringToolList?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MeasuringToolTableViewCell", for: indexPath) as! MeasuringToolTableViewCell

        cell.separatorInset = UIEdgeInsets.zero

        cell.toolNameLabel.text = measuringToolList?[indexPath.item].name
        cell.toolSubnameLabel.text = measuringToolList?[indexPath.item].subname
        return cell
    }
}

extension MeasuringToolViewController: UITableViewDelegate {

}
