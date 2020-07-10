//
//  TimerSettingViewController + Notification.swift
//  Amoogye
//
//  Created by 임수현 on 2020/07/06.
//  Copyright © 2020 KookKook. All rights reserved.
//

import UIKit
import UserNotifications

extension TimerSettingViewController {
    func checkNotificationAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound], completionHandler: {didAllow, _ in
            if !didAllow {
                // 알림 권한을 거부한 경우, 앱 설정 화면으로 이동
                self.alertPermissionDenied()
            }
        })
    }

    func alertPermissionDenied() {
        self.tabBarController?.selectedIndex = 0
        let alert = UIAlertController(title: "권한 필요", message: "타이머 기능을 사용하려면 알림 권한 허용이 필요합니다.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                        print("Settings opened: \(success)") // Prints true
                    })
                }
            }
        }
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
}
