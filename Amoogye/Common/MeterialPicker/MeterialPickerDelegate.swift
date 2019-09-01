//
//  MeterialPickerDelegate.swift
//  Amoogye
//
//  Created by 임수현 on 16/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol MeterialPickerDelegate: class {
    func selectMeterial(name: String)
    func openMeterialSearchView()
    func closeMeterialSearchView()
}
