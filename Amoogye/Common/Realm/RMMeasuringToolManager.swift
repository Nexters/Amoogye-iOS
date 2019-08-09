//
//  RMMeasuringToolManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import RealmSwift

class RMMeasuringToolManager: MeasuringToolManager {
    var realm: Realm?

    override init() {
        super.init()

        realm = try? Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
    }

    func addMeasuringTool(object: MeasuringTool) {
        try! realm?.write {
            realm?.add(inputFromData(input: object))
        }
    }

    func deleteMeasuringTool(object: MeasuringTool) {
        try! realm?.write {
            realm?.delete(inputFromData(input: object))
        }
    }

    func getMeausringToolList() -> [MeasuringTool] {
        var measuringToolList = [MeasuringTool]()

        if let realmMeasuringToolList = realm?.objects(RMMeasuringTool.self) {
            for realmMeasuringTool in realmMeasuringToolList {
                measuringToolList.append(outputFromRealm(realmData: realmMeasuringTool))
            }
        }

        return measuringToolList
    }
}

extension RMMeasuringToolManager {
    private func realmUnitFromInputUnit(inputUnit: MeasuringUnit) -> RMMeasuringUnit {
        let realmUnit = RMMeasuringUnit(name: inputUnit.name, value: inputUnit.value)
        realmUnit.type = inputUnit.type

        return realmUnit
    }

    private func outputUnitFromRealmUnit(realmUnit: RMMeasuringUnit) -> MeasuringUnit {
        return MeasuringUnit(name: realmUnit.name, value: realmUnit.value, type: realmUnit.type)
    }
}

extension RMMeasuringToolManager {
    private func inputFromData(input: MeasuringTool) -> RMMeasuringTool {
        let realmData = RMMeasuringTool()

        realmData.name = input.name
        realmData.measuringUnit = realmUnitFromInputUnit(inputUnit: input.measuringUnit)
        realmData.quantity = input.quantity

        return realmData
    }

    private func outputFromRealm(realmData: RMMeasuringTool) -> MeasuringTool {
        let name = realmData.name
        let quantity = realmData.quantity
        let measuringUnit = outputUnitFromRealmUnit(realmUnit: realmData.measuringUnit)

        return MeasuringTool(name: name, quantity: quantity, measuringUnit: measuringUnit)
    }
}
