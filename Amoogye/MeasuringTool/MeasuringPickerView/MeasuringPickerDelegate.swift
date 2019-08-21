//
//  MeasuringPickerDelegate.swift
//  Amoogye
//
//  Created by JunHui Kim on 18/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol MeasuringPickerDelegate: class {
    func selectTool(name: String)
    func selectInt(number: String)
    func selectFloat(number: String)
}
