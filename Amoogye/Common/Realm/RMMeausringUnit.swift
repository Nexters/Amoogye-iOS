//
//  RMMeausringUnit.swift
//  Amoogye
//
//  Created by JunHui Kim on 09/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import RealmSwift

final class RMMeasuringUnit: Object {
    @objc dynamic var name = ""
    @objc dynamic var value = 0.0

    @objc private dynamic var typeRaw = 0
    var type: MeasuringType {
        get {
            return MeasuringType(rawValue: typeRaw)!
        }
        set {
            typeRaw = newValue.rawValue
        }
    }

    convenience init(name: String, value: Double) {
        self.init()
        self.name = name
        self.value = value
    }
}
