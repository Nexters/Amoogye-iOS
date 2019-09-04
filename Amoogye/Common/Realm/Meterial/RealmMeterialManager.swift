//
//  RealmMeterialManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import RealmSwift

class RealmMeterialManager {
    var realm: Realm?

    init() {
        realm = try? Realm()
        print("[Meterial Realm Path]  \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
}

extension RealmMeterialManager: MeterialManager {
    func addMeterial(_ meterial: Meterial) {
        if checkDuplicatedMeterailName(name: meterial.name) {
            print("Error: Duplicated Meterial Name! - [\(meterial.name)]")
            return
        }

        let realmMeterial = RealmMeterial()
        realmMeterial.name = meterial.name
        realmMeterial.unitQuantity = meterial.unitQuantity

        try! realm?.write {
            realm?.add(realmMeterial)
        }
    }

    func getMeterialList() -> [Meterial] {
        return getRealmMeterialList().map {
            Meterial(name: $0.name, unitQuantity: $0.unitQuantity)
        }
    }
}

extension RealmMeterialManager {
    private func checkDuplicatedMeterailName(name: String) -> Bool {
        return getMeterialList().reduce(false) {
            if name == $1.name {
                return true
            }
            return false
        }
    }

    private func getRealmMeterialList() -> [RealmMeterial] {
        var realmMeterialList = [RealmMeterial]()

        guard let realmObjectList = realm?.objects(RealmMeterial.self) else {
            return realmMeterialList
        }

        for realmObject in realmObjectList {
            realmMeterialList.append(realmObject)
        }
        return realmMeterialList
    }
}
