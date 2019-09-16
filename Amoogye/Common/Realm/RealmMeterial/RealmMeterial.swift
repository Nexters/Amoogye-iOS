//
//  RealmMeterial.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmMeterial: Object {
    @objc dynamic var name = ""
    @objc dynamic var unitQuantity = 0.0
}
