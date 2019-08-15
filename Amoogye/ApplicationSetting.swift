//
//  ApplicationSetting.swift
//  Amoogye
//
//  Created by JunHui Kim on 11/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

enum SettingType: String {
    case Screen = "꺼짐방지"
    case Sound = "사운드"
    case Vibrate = "진동"
    case FirstExecution = "첫실행"

    func userSetting() -> Bool {
        if let settingValue = UserDefaults.standard.value(forKey: self.rawValue) {
            return settingValue as! Bool
        }
        // Default Value
        return true
    }
}

struct ApplicationSetting {
    var screenSettingList: [SettingType]
    var alarmSettingList: [SettingType]

    init() {
        screenSettingList = [.Screen]
        alarmSettingList = [.Sound, .Vibrate]
    }
}
