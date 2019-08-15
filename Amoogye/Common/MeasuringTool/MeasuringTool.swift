//
//  MeasuringTool.swift
//  Amoogye
//
//  Created by JunHui Kim on 11/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

struct MeasuringTool {
    var toolType: MeasuringToolType
    var unitType: MeasuringUnitType
    var name: String
    var subname: String
    var quantity: Double
    var isOn: Bool
    var isEditable: Bool = true
    var recentUsed: Date = Date()

    init(toolType: MeasuringToolType, unitType: MeasuringUnitType, name: String, subname: String, quantity: Double, isOn: Bool) {
        self.toolType = toolType
        self.unitType = unitType
        self.name = name
        self.subname = subname
        self.quantity = quantity
        self.isOn = isOn
    }

    init(toolType: MeasuringToolType, unitType: MeasuringUnitType, name: String, quantity: Double, isOn: Bool) {
        var subname = String(quantity)

        switch unitType {
        case .volume:
            subname = subname + "ml"
        case .mass:
            subname = subname + "g"
        default:
            subname = "unknown"
        }

        self.init(toolType: toolType, unitType: unitType, name: name, subname: subname, quantity: quantity, isOn: isOn)
    }

    init(toolType: MeasuringToolType, unitType: MeasuringUnitType, name: String, subname: String, quantity: Double, isOn: Bool, isEditable: Bool, recentUsed: Date) {
        self.toolType = toolType
        self.unitType = unitType
        self.name = name
        self.subname = subname
        self.quantity = quantity
        self.isOn = isOn
        self.isEditable = isEditable
        self.recentUsed = recentUsed
    }
}
