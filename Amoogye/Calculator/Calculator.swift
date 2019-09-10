//
//  Calculator.swift
//  Amoogye
//
//  Created by JunHui Kim on 05/09/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

class Calculator {
    // TODO
    //    var historyManager: HistoryManager?

    //    init(_ historyManager: HistoryManager) {
    //        self.historyManager = historyManager
    //    }

    // 재료 모드
    func calculate(srcAmount: String, srcUnit: MeasuringTool, dstTool: MeasuringTool) -> String {
        guard let amount = Double(srcAmount),
            let quantity = Double(srcUnit.quantity),
            let tool = Double(dstTool.quantity) else {
                print("Error: Don't calculate! - [srcAmount: \(srcAmount), srcUnit.quantity: \(srcUnit.quantity), dstTool.quantity: \(dstTool.quantity)]")
                return ""
        }

        let result = (amount * quantity / tool).formatToFloatingString()

        return "\(result) \(dstTool.name)"
    }

    // 재료 모드 (재료 선택)
    func calculate(srcAmount: String, srcMeterial: Meterial, dstTool: MeasuringTool) -> String {
        guard let amount = Double(srcAmount),
            let tool = Double(dstTool.quantity) else {
                print("Error: Don't calculate! - [srcAmount: \(srcAmount), dstTool.quantity: \(dstTool.quantity)]")
                return ""
        }

        let result = (amount * srcMeterial.unitQuantity / tool).formatToFloatingString()

        return "\(result) \(dstTool.name)"
    }

    // 인원 모드
    func calculate(srcPortion: String, srcAmount: String, srcUnit: MeasuringTool, dstPortion: String) -> String {
        guard let _srcPortion = Double(srcPortion),
            let amount = Double(srcAmount),
            let quantity = Double(srcUnit.quantity),
            let _dstPortion = Double(dstPortion) else {
                print("Error: Don't calculate! - [srcPortion: \(srcPortion), srcAmount: \(srcAmount), srcUnit.quantity: \(srcUnit.quantity), dstPortion: \(dstPortion)]")
                return ""
        }

        let result = (amount * quantity / _srcPortion * _dstPortion).formatToFloatingString()

        return "\(result) \(srcUnit.name)"
    }

    // 인원 모드 (재료 선택)
    func calculate(srcPortion: String, srcAmount: String, srcMeterial: Meterial, dstPortion: String) -> String {
        guard let _srcPortion = Double(srcPortion),
            let amount = Double(srcAmount),
            let _dstPortion = Double(dstPortion) else {
                print("Error: Don't calculate! - [srcPortion: \(srcPortion), srcAmount: \(srcAmount), dstPortion: \(dstPortion)]")
                return ""
        }

        let result = (amount * srcMeterial.unitQuantity / _srcPortion * _dstPortion).formatToFloatingString()

        return "\(result) \(srcMeterial.name)"
    }

    // 재료 + 인원 모드
    func calculate(srcPortion: String, srcAmount: String, srcUnit: MeasuringTool, dstPortion: String, dstTool: MeasuringTool) -> String {
        guard let _srcPortion = Double(srcPortion),
            let amount = Double(srcAmount),
            let quantity = Double(srcUnit.quantity),
            let _dstPortion = Double(dstPortion),
            let tool = Double(dstTool.quantity) else {
                print("Error: Don't calculate! - [srcPortion: \(srcPortion), srcAmount: \(srcAmount), srcUnit.quantity: \(srcUnit.quantity), dstPortion: \(dstPortion), dstTool.quantity: \(dstTool.quantity)]")
                return ""
        }

        let result = (amount * quantity / _srcPortion / tool * _dstPortion).formatToFloatingString()

        return "\(result) \(dstTool.name)"
    }

    // 재료 + 인원 모드 (재료 선택)
    func calculate(srcPortion: String, srcAmount: String, srcMeterial: Meterial, dstPortion: String, dstTool: MeasuringTool) -> String {
        guard let _srcPortion = Double(srcPortion),
            let amount = Double(srcAmount),
            let _dstPortion = Double(dstPortion),
            let tool = Double(dstTool.quantity) else {
                print("Error: Don't calculate! - [srcPortion: \(srcPortion), srcAmount: \(srcAmount), dstPortion: \(dstPortion), dstTool.quantity: \(dstTool.quantity)]")
                return ""
        }

        let result = (amount * srcMeterial.unitQuantity / _srcPortion / tool * _dstPortion).formatToFloatingString()

        return "\(result) \(dstTool.name)"
    }
}
