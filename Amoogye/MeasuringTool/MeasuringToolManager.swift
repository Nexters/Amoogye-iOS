//
//  MeasuringToolManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class MeasuringToolManager {
    var measuringToolList: [MeasuringTool]

    init() {
        measuringToolList = []
    }

    // 새로운 계량도구 생성
    func newMeasuringToolWith(_ criteria: MeasuringTool, name toolName: String, measuringCount count: Double) -> MeasuringTool {
        let quantity = criteria.absoluteQuantity * count
        return MeasuringTool(name: toolName, quantity: quantity, measuringUnit: criteria.measuringUnit)
    }
}
