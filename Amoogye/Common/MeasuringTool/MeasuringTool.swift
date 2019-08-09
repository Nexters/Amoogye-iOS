//
//  MeasuringTool.swift
//  Amoogye
//
//  Created by JunHui Kim on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

struct MeasuringTool {
    var name: String
    var subname: String {
        get {
            return "\(String(quantity))\(measuringUnit.name)"
        }
    }
    var quantity: Double
    var measuringUnit: MeasuringUnit
    var absoluteQuantity: Double {
        get {
            return quantity * measuringUnit.value
        }
    }
}

extension MeasuringTool {
    static func basicMeasuringToolList() -> [MeasuringTool] {
        let unitList = MeasuringUnit.basicMeasuringUnitList()
        var toolList = [MeasuringTool]()

        toolList.append(MeasuringTool(name: "시시", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "밀리리터", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "리터", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "밀리그램", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "그램", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "킬로그램", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "티스푼", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "테이블스푼", quantity: 1, measuringUnit: unitList[toolList.count]))
        toolList.append(MeasuringTool(name: "컵", quantity: 1, measuringUnit: unitList[toolList.count]))

        return toolList
    }
}
