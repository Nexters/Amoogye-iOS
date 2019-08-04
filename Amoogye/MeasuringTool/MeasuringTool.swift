//
//  MeasuringTool.swift
//  Amoogye
//
//  Created by JunHui Kim on 03/08/2019.
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

struct MeasuringTool {
    var name: String
    var unit: MeasuringUnit
    var quantity: Float

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

    init(name: String, unit: MeasuringUnit, quantity: Float) {
        self.name = name
        self.unit = unit
        self.quantity = quantity
    }
}
