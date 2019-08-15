//
//  MeasuringToolManager.swift
//  Amoogye
//
//  Created by JunHui Kim on 03/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol MeasuringToolManager {
    func addMeasuringTool(_ tool: MeasuringTool)
    func deleteMeasuringTool(_ tool: MeasuringTool)
    func updateMeasuringTool(_ tool: MeasuringTool)
    func getMeasuringTool(_ name: String) -> MeasuringTool?
    func getMeasuringToolList() -> [MeasuringTool]
}
