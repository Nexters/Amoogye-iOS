//
//  TabBarController.swift
//  Amoogye
//
//  Created by 임수현 on 13/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit
import UserNotifications

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        UNUserNotificationCenter.current().delegate = self
        self.tabBar.isTranslucent = true

        let selectedColor   = UIColor.amDarkBlueGrey
        let unselectedColor = UIColor.amDarkBlueGreyWithOpacity(opacity: 0.5)

        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: selectedColor], for: .selected)

        if let items = self.tabBar.items {
            for item in items {
                    switch item.title! {
                    case "아무계":
                        item.image = UIImage(named: "calculatorInactive")?.withRenderingMode(.alwaysOriginal)
                        item.selectedImage = UIImage(named: "calculatorActive")?.withRenderingMode(.alwaysOriginal)
                    case "타이머":
                        item.image = UIImage(named: "timerInactive")?.withRenderingMode(.alwaysOriginal)
                        item.selectedImage = UIImage(named: "timerActive")?.withRenderingMode(.alwaysOriginal)
                    case "계량도구":
                        item.image = UIImage(named: "measuringToolInactive")?.withRenderingMode(.alwaysOriginal)
                        item.selectedImage = UIImage(named: "measuringToolActive")?.withRenderingMode(.alwaysOriginal)
                    case "설정":
                        item.image = UIImage(named: "settingInactive")?.withRenderingMode(.alwaysOriginal)
                        item.selectedImage = UIImage(named: "settingActive")?.withRenderingMode(.alwaysOriginal)
                    default:
                        print("[Tab Bar Error] \(item.title!) is not found")
                    }

            }
        }
    }
}

extension TabBarController: UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, openSettingsFor notification: UNNotification?) {
        let settingsViewController = UIViewController()
        settingsViewController.view.backgroundColor = .gray
        self.present(settingsViewController, animated: true, completion: nil)
    }
}
