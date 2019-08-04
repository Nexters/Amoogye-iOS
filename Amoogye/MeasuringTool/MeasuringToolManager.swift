//
//  MeasuringToolManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class MeasuringToolManager {
    // 새로운 계량도구 생성
    func newMeasuringToolWith(_ criteria: MeasuringTool, name toolName: String, measuringCount count: Float) -> MeasuringTool {
        let quantity = criteria.quantity * count
        return MeasuringTool(name: toolName, unit: criteria.unit, quantity: quantity)
    }
}
