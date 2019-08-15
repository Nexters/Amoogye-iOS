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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        if SettingType.FirstExecution.userSetting() {
            setupDefaultMeasuringTool()
            UserDefaults.standard.set(false, forKey: SettingType.FirstExecution.rawValue)
        }
        setupDefaultMeasuringTool()
        application.isIdleTimerDisabled = SettingType.Screen.userSetting()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
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
