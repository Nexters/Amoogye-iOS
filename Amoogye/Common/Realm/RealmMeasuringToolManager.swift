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
        guard let realmTool = getRealmTool(name: tool.name) else {
            return
        }

        try! realm?.write {
            realm?.delete(realmTool)
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
        return getRealmToolList().map { toolFrom(realmTool: $0) }
    }

    func getUsingOnMeasuringToolList() -> [MeasuringTool] {
        return getMeasuringToolList().filter { $0.isOn == true }
    }

    func getBasicMeasuringToolList() -> [MeasuringTool] {
        return getMeasuringToolList().filter { $0.toolType == .basic }
    }

    func getLivingMeasuringToolList() -> [MeasuringTool] {
        return getMeasuringToolList().filter { $0.toolType == .living }
    }

    func getUsingOnBasicMeasuringToolList() -> [MeasuringTool] {
        return getBasicMeasuringToolList().filter { $0.isOn == true }
    }

    func getUsingOnLivingMeasuringToolList() -> [MeasuringTool] {
        return getLivingMeasuringToolList().filter { $0.isOn == true }
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
        realmTool.isEditable = tool.isEditable
        realmTool.recentUsed = tool.recentUsed

        return realmTool
    }

    private func toolFrom(realmTool: RealmMeasuringTool) -> MeasuringTool {
        let toolType = MeasuringToolType(rawValue: realmTool.toolType)!
        let unitType = MeasuringUnitType(rawValue: realmTool.unitType)!
        let name = realmTool.name
        let subname = realmTool.subname
        let quantity = realmTool.quantity
        let isOn = realmTool.isOn
        let isEditable = realmTool.isEditable
        let recentUsed = realmTool.recentUsed

        return MeasuringTool(toolType: toolType, unitType: unitType, name: name, subname: subname, quantity: quantity, isOn: isOn, isEditable: isEditable, recentUsed: recentUsed)
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
