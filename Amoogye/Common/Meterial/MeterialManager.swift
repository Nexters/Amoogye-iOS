//
//  MeterialManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol MeterialManager {
    func addMeterial(_ meterial: Meterial)
    func getMeterialList() -> [Meterial]
}
