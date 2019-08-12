//
//  SwinjectStoryboard+Setup.swift
//  Amoogye
//
//  Created by JunHui Kim on 09/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Swinject
import SwinjectStoryboard
import SwinjectAutoregistration

extension SwinjectStoryboard {
    @objc class func setup() {
        // RMMeasuringToolManager
        defaultContainer.autoregister(RMMeasuringToolManager.self, initializer: RMMeasuringToolManager.init)

        defaultContainer.storyboardInitCompleted(MeasuringToolViewController.self) { r, c in
            c.measuringToolManager = r ~> RMMeasuringToolManager.self
        }
        defaultContainer.storyboardInitCompleted(GetCountForNewToolViewController.self) { r, c in
            c.measuringToolManager = r ~> RMMeasuringToolManager.self
        }
        defaultContainer.storyboardInitCompleted(CompleteNewToolViewController.self) { r, c in
            c.measuringToolManager = r ~> RMMeasuringToolManager.self
        }

        // ApplicationSetting
        defaultContainer.autoregister(ApplicationSetting.self, initializer: ApplicationSetting.init)

        defaultContainer.storyboardInitCompleted(SettingViewController.self) {r, c in
            c.appSetting = r ~> ApplicationSetting.self
        }
    }
}
