//
//  RealmMeasuringToolManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 04/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMeasuringToolManager: MeasuringToolManager {
    var realm: Realm?

    init() {
        realm = try? Realm()
        print("RealmPath: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }

    func addMeasuringTool(_ tool: MeasuringTool) {
        if checkDuplicatedToolName(name: tool.name) {
            print("Error: Duplicated Tool Name! - [\(tool.name)]")
            return
        }

        try! realm?.write {
            realm?.add(realmToolFrom(tool: tool))
        }
    }

    func deleteMeasuringTool(_ tool: MeasuringTool) {
        try! realm?.write {
            realm?.delete(realmToolFrom(tool: tool))
        }
    }

    func updateMeasuringTool(_ tool: MeasuringTool) {
        try! realm?.write {
            getRealmTool(name: tool.name)?.isOn = tool.isOn
        }
    }

    func getMeasuringTool(_ name: String) -> MeasuringTool? {
        guard let realmTool = getRealmTool(name: name) else {
            return nil
        }
        return toolFrom(realmTool: realmTool)
    }

    func getMeasuringToolList() -> [MeasuringTool] {
        var measuringToolList = [MeasuringTool]()

        for realmTool in getRealmToolList() {
            measuringToolList.append(toolFrom(realmTool: realmTool))
        }
        return measuringToolList
    }

    func getUsingOnMeasuringToolList() -> [MeasuringTool] {
        var usingOnTooList = [MeasuringTool]()

        for measuringTool in getMeasuringToolList() {
            if measuringTool.isOn == true {
                usingOnTooList.append(measuringTool)
            }
        }

        return usingOnTooList
    }

    func getBasicMeasuringToolList() -> [MeasuringTool] {
        var basicToolList = [MeasuringTool]()

        for realmTool in getRealmToolList() {
            let tool = toolFrom(realmTool: realmTool)

            if tool.toolType == .basic {
                basicToolList.append(tool)
            }
        }

        return basicToolList
    }

    func getLivingMeasuringToolList() -> [MeasuringTool] {
        var livingToolList = [MeasuringTool]()

        for realmTool in getRealmToolList() {
            let tool = toolFrom(realmTool: realmTool)

            if tool.toolType == .living {
                livingToolList.append(tool)
            }
        }

        return livingToolList
    }

    func getUsingOnBasicMeasuringToolList() -> [MeasuringTool] {
        var usingOnToolList = [MeasuringTool]()

        for basicTool in getBasicMeasuringToolList() {
            if basicTool.isOn {
                usingOnToolList.append(basicTool)
            }
        }

        return usingOnToolList
    }

    func getUsingOnLivingMeasuringToolList() -> [MeasuringTool] {
        var usingOnToolList = [MeasuringTool]()

        for livingTool in getLivingMeasuringToolList() {
            if livingTool.isOn {
                usingOnToolList.append(livingTool)
            }
        }

        return usingOnToolList
    }

    func newMeasuringTool(name: String, criteriaTool: MeasuringTool, count: String) -> MeasuringTool {
        return MeasuringTool(toolType: .living, unitType: criteriaTool.unitType, name: name, quantity: criteriaTool.quantity * (Double(count) ?? 0), isOn: true)
    }
}

extension RealmMeasuringToolManager {
    func checkDuplicatedToolName(name: String) -> Bool {
        for tool in getMeasuringToolList() {
            if name == tool.name {
                return true
            }
        }
        return false
    }

    private func realmToolFrom(tool: MeasuringTool) -> RealmMeasuringTool {
        let realmTool = RealmMeasuringTool()

        realmTool.toolType = tool.toolType.rawValue
        realmTool.unitType = tool.unitType.rawValue
        realmTool.name = tool.name
        realmTool.subname = tool.subname
        realmTool.quantity = tool.quantity
        realmTool.isOn = tool.isOn

        return realmTool
    }

    private func toolFrom(realmTool: RealmMeasuringTool) -> MeasuringTool {
        let toolType = MeasuringToolType(rawValue: realmTool.toolType)!
        let unitType = MeasuringUnitType(rawValue: realmTool.unitType)!
        let name = realmTool.name
        let subname = realmTool.subname
        let quantity = realmTool.quantity
        let isOn = realmTool.isOn

        return MeasuringTool(toolType: toolType, unitType: unitType, name: name, subname: subname, quantity: quantity, isOn: isOn)
    }

    private func getRealmToolList() -> [RealmMeasuringTool] {
        var realmToolList = [RealmMeasuringTool]()

        guard let realmObjectList = realm?.objects(RealmMeasuringTool.self) else {
            return realmToolList
        }

        for realmObject in realmObjectList {
            realmToolList.append(realmObject)
        }
        return realmToolList
    }

    private func getRealmTool(name: String) -> RealmMeasuringTool? {
        for realmTool in getRealmToolList() {
            if realmTool.name == name {
                return realmTool
            }
        }
        return nil
    }
}
