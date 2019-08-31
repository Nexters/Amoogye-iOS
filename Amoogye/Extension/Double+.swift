//
//  Double+.swift
//  Amoogye
//
//  Created by JunHui Kim on 24/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

extension Double {
    func formatToFloatingString() -> String {
        if self == Double(Int(self)) {
            return String(format: "%d", Int(self))
        } else {
            return String(format: "%.1f", self)
        }
    }
}
