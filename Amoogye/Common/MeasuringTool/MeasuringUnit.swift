//
//  MeasuringUnit.swift
//  Amoogye
//
//  Created by JunHui Kim on 09/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

enum MeasuringType: Int {
    case unknown = 0
    case volume
    case mass
}

struct MeasuringUnit {
    var name: String
    var value: Double
    var type: MeasuringType
}

extension MeasuringUnit {
    static func basicMeasuringUnitList() -> [MeasuringUnit] {
        var unitList = [MeasuringUnit]()

        unitList.append(MeasuringUnit(name: "CC", value: 1, type: .volume))
        unitList.append(MeasuringUnit(name: "ml", value: 1, type: .volume))
        unitList.append(MeasuringUnit(name: "L", value: 1000, type: .volume))
        unitList.append(MeasuringUnit(name: "mg", value: 1, type: .mass))
        unitList.append(MeasuringUnit(name: "g", value: 100, type: .mass))
        unitList.append(MeasuringUnit(name: "kg", value: 100000, type: .mass))
        unitList.append(MeasuringUnit(name: "tsp", value: 5, type: .volume))
        unitList.append(MeasuringUnit(name: "tbsp", value: 15, type: .volume))
        unitList.append(MeasuringUnit(name: "cup", value: 240, type: .volume))

        return unitList
    }
}
