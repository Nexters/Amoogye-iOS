//
//  SettingViewController.swift
//  Amoogye
//
//  Created by 임수현 on 25/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController {
    var appSetting: ApplicationSetting?

    let devEmailList = ["skjflgglf@gmail.com", "hihiboss@gmail.com"]

    @IBOutlet weak var settingTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        settingTableView.dataSource = self
        settingTableView.delegate = self

        // xib
        let onoff = UINib(nibName: "OnOffCell", bundle: nil)
        settingTableView.register(onoff, forCellReuseIdentifier: "OnOffCell")

        let devcontact = UINib(nibName: "DeveloperContactCell", bundle: nil)
        settingTableView.register(devcontact, forCellReuseIdentifier: "DeveloperContactCell")

        let title = UINib(nibName: "SettingTitleCell", bundle: nil)
        settingTableView.register(title, forCellReuseIdentifier: "SettingTitleCell")
    }
}

extension SettingViewController {
    @objc func setScreenSettingState(_ sender: UISwitch) {
        let setting = appSetting!.screenSettingList[sender.tag]
        UserDefaults.standard.set(sender.isOn, forKey: setting.rawValue)
        UIApplication.shared.isIdleTimerDisabled = sender.isOn
    }

    @objc func setAlarmSettingState(_ sender: UISwitch) {
        let setting = appSetting!.alarmSettingList[sender.tag]
        UserDefaults.standard.set(sender.isOn, forKey: setting.rawValue)
    }
}

extension SettingViewController: UITableViewDataSource {

    // number of sections
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    // number of rows in section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return appSetting!.screenSettingList.count
        case 1:
            return appSetting!.alarmSettingList.count
        case 2:
            return devEmailList.count
        default:
            return 0
        }
    }

    // cell for row
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {
        case 0: // 화면설정
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell", for: indexPath) as! OnOffCell
            let settingItem = appSetting!.screenSettingList[indexPath.row]
            cell.titleLabel.text = settingItem.rawValue
            cell.onoffSwitch.isOn = settingItem.userSetting()
            cell.onoffSwitch.tag = indexPath.row
            cell.onoffSwitch.addTarget(self, action: #selector(setScreenSettingState), for: .valueChanged)

            return cell

        case 1: // 알람설정
            let cell = tableView.dequeueReusableCell(withIdentifier: "OnOffCell", for: indexPath) as! OnOffCell
            let settingItem = appSetting!.alarmSettingList[indexPath.row]
            cell.titleLabel.text = settingItem.rawValue
            cell.onoffSwitch.isOn = settingItem.userSetting()
            cell.onoffSwitch.tag = indexPath.row
            cell.onoffSwitch.addTarget(self, action: #selector(setAlarmSettingState), for: .valueChanged)
            return cell

        case 2: // 개발자 컨택
            let cell = tableView.dequeueReusableCell(withIdentifier: "DeveloperContactCell", for: indexPath) as! DeveloperContactCell
            cell.titleLabel.text = devEmailList[indexPath.row]
            return cell

        default:
            return UITableViewCell()
        }
    }

    // header view
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerView = tableView.dequeueReusableCell(withIdentifier: "SettingTitleCell") as! SettingTitleCell

        switch section {
        case 0:
            headerView.titleLabel.text = "화면설정"

        case 1:
            headerView.titleLabel.text = "알람설정"

        case 2:
            headerView.titleLabel.text = "개발자 컨택"

        default:
            return nil
        }

        return headerView
    }

    // header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }

    // footer height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
}

extension SettingViewController: UITableViewDelegate {

}
