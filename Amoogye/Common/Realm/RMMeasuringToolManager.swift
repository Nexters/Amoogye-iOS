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

    private func inputData(input: MeasuringTool) -> RMMeasuringTool {
        let realmData = RMMeasuringTool()

        realmData.name = input.name
        realmData.unit = input.unit
        realmData.quantity = input.quantity

        return realmData
    }

    private func outputData(realmData: RMMeasuringTool) -> MeasuringTool {
        var output = MeasuringTool()

        output.name = realmData.name
        output.unit = realmData.unit
        output.quantity = realmData.quantity

        return output
    }

    func addMeasuringTool(object: MeasuringTool) {
        try! realm?.write {
            realm?.add(inputData(input: object))
        }
    }

    func deleteMeasuringTool(object: MeasuringTool) {
        try! realm?.write {
            realm?.delete(inputData(input: object))
        }
    }

    func getMeausringToolList() -> [MeasuringTool] {
        var measuringToolList = [MeasuringTool]()

        if let realmMeasuringToolList = realm?.objects(RMMeasuringTool.self) {
            for realmMeasuringTool in realmMeasuringToolList {
                measuringToolList.append(outputData(realmData: realmMeasuringTool))
            }
        }

        return measuringToolList
    }
}
