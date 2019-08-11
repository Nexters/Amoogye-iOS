//
//  MeasuringUnit.swift
//  Amoogye
//
//  Created by JunHui Kim on 11/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

// 계량 단위
enum MeasuringUnit: String {
    case cubicCentimeter = "cc"
    case millilitre = "ml"
    case litre = "L"
    case milligram = "mg"
    case gram = "g"
    case kilogram = "kg"
    case teaSpoon = "tsp"
    case tableSpoon = "tbsp"
    case cup = "cup"
    case unknown = ""
}

enum MeasuringType: Int {
    case unknown = 0
    case volume
    case mass
}

struct FixedMeasuringUnit {
    var name: String
    var value: Double
    var type: MeasuringType
}

extension FixedMeasuringUnit {
    static func basicMeasuringUnitList() -> [FixedMeasuringUnit] {
        var unitList = [FixedMeasuringUnit]()
        
        unitList.append(FixedMeasuringUnit(name: "CC", value: 1, type: .volume))
        unitList.append(FixedMeasuringUnit(name: "ml", value: 1, type: .volume))
        unitList.append(FixedMeasuringUnit(name: "L", value: 1000, type: .volume))
        unitList.append(FixedMeasuringUnit(name: "mg", value: 1, type: .mass))
        unitList.append(FixedMeasuringUnit(name: "g", value: 100, type: .mass))
        unitList.append(FixedMeasuringUnit(name: "kg", value: 100000, type: .mass))
        unitList.append(FixedMeasuringUnit(name: "tsp", value: 5, type: .volume))
        unitList.append(FixedMeasuringUnit(name: "tbsp", value: 15, type: .volume))
        unitList.append(FixedMeasuringUnit(name: "cup", value: 240, type: .volume))
        
        return unitList
    }
}
