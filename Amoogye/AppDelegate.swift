//
//  AppDelegate.swift
//  Amoogye
//
//  Created by 임수현 on 13/07/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let timerModel = TimerModel.shared

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        timerModel.setDefaultTimerState()

        // 첫 실행시 기본 데이터 설정
        if SettingType.FirstExecution.userSetting() {
            setupDefaultMeasuringTool()
            setupDefaultMeterial()
            UserDefaults.standard.set(false, forKey: SettingType.FirstExecution.rawValue)
        }

        // 화면 꺼짐 방지 설정
        application.isIdleTimerDisabled = SettingType.Screen.userSetting()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        timerModel.saveTimerState()
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // background -> foreground
        timerModel.setDefaultTimerState()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        timerModel.saveTimerState()
    }
}

extension AppDelegate {
    func setupDefaultMeasuringTool() {
        var defaultMeasuringToolList = [MeasuringTool]()
        let measuringToolManager = RealmMeasuringToolManager()

        // MARK: - Default Basic Measuring Tools
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .volume, name: "CC", subname: "시시", quantity: String(1), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .volume, name: "ml", subname: "밀리리터", quantity: String(1), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .volume, name: "L", subname: "리터", quantity: String(1000), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .mass, name: "mg", subname: "밀리그램", quantity: String(1), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .mass, name: "g", subname: "그램", quantity: String(1*100), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .mass, name: "kg", subname: "킬로그램", quantity: String(1*100*1000), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .volume, name: "작은술", subname: "tsp", quantity: String(5), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .volume, name: "큰술", subname: "tbsp", quantity: String(15), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .basic, unitType: .volume, name: "컵", subname: "cup", quantity: String(240), isOn: true))

        // MARK: - Default Living Measuring Tools
        defaultMeasuringToolList.append(MeasuringTool(toolType: .living, unitType: .volume, name: "소주잔", quantity: String(50), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .living, unitType: .volume, name: "종이컵", quantity: String(150), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .living, unitType: .volume, name: "김용기", quantity: String(300), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .living, unitType: .volume, name: "햇반그릇", quantity: String(450), isOn: true))
        defaultMeasuringToolList.append(MeasuringTool(toolType: .living, unitType: .volume, name: "큰국자", quantity: String(15), isOn: true))

        for tool in defaultMeasuringToolList {
            var defaultTool = tool
            defaultTool.isEditable = false
            measuringToolManager.addMeasuringTool(defaultTool)
        }
    }

    func setupDefaultMeterial() {
        var defaultMeterialList = [Meterial]()
        let meterialManager = RealmMeterialManager()

        defaultMeterialList.append(Meterial(name: "소금", unitQuantity: 1.3))

        for meterial in defaultMeterialList {
            meterialManager.addMeterial(meterial)
        }
    }
}
