//
//  MeasuringTool.swift
//  Amoogye
//
//  Created by JunHui Kim on 11/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

struct MeasuringTool {
    var name: String
    var unit: MeasuringUnit
    var quantity: Double
    
    var subname: String {
        get {
            return String(quantity) + unit.rawValue
        }
    }
    
    init() {
        self.name = ""
        self.unit = .unknown
        self.quantity = 0.0
    }
    
    init(name: String, unit: MeasuringUnit, quantity: Double) {
        self.name = name
        self.unit = unit
        self.quantity = quantity
    }
}

struct FixedMeasuringTool {
    var name: String
    var subname: String {
        get {
            return "\(String(quantity))\(measuringUnit.name)"
        }
    }
    var quantity: Double
    var measuringUnit: FixedMeasuringUnit
    var absoluteQuantity: Double {
        get {
            return quantity * measuringUnit.value
        }
    }
}

extension FixedMeasuringTool {
    static func basicMeasuringToolList() -> [FixedMeasuringTool] {
        let unitList = FixedMeasuringUnit.basicMeasuringUnitList()
        var toolList = [FixedMeasuringTool]()
        
        toolList.append(FixedMeasuringTool(name: "시시", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "밀리리터", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "리터", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "밀리그램", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "그램", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "킬로그램", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "티스푼", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "테이블스푼", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(FixedMeasuringTool(name: "컵", quantity: 1, measuringUnit: unitList[toolList.count]))
        
        return toolList
    }
}
