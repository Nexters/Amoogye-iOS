//
//  MeterialPickerDelegate.swift
//  Amoogye
//
//  Created by 임수현 on 16/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol MeterialPickerDelegate: class {
    func selectMeterial(row: Int, name: String)
    func meterialSearchViewOpen()
    func meterialSearchViewClose()
}
