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

        if SettingType.FirstExecution.userSetting() {
            setupDefaultMeasuringTool()
            UserDefaults.standard.set(false, forKey: SettingType.FirstExecution.rawValue)
        }
        setupDefaultMeasuringTool()
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
        let measuringToolManager = RealmMeasuringToolManager()
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .volume, name: "CC", subname: "시시", quantity: 1, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .volume, name: "ml", subname: "밀리리터", quantity: 1, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .volume, name: "L", subname: "리터", quantity: 1000, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .mass, name: "mg", subname: "밀리그램", quantity: 1, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .mass, name: "g", subname: "그램", quantity: 1*100, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .mass, name: "kg", subname: "킬로그램", quantity: 1*100*1000, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .volume, name: "작은술", subname: "tsp", quantity: 5, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .volume, name: "큰술", subname: "tbsp", quantity: 15, isOn: true))
        measuringToolManager.addMeasuringTool(MeasuringTool(toolType: .basic, unitType: .volume, name: "컵", subname: "cup", quantity: 240, isOn: true))
    }
}
