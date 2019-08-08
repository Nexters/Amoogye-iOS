//
//  File.swift
//  Amoogye
//
//  Created by JunHui Kim on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import RealmSwift

final class RMMeasuringTool: Object {
    @objc dynamic var name = ""
    @objc dynamic var quantity = 0.0

    @objc private dynamic var unitRaw = ""
    var unit: MeasuringUnit {
        get {
            return MeasuringUnit(rawValue: unitRaw)!
        }
        set {
            unitRaw = newValue.rawValue
        }
    }
}
