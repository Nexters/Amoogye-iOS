//
//  NumericKeyboardDelegate.swift
//  Amoogye
//
//  Created by JunHui Kim on 14/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol NumericKeyboardDelegate: class {
    func clickNumberButton(number: String)
    func clickDeleteButton()
    func clickDotButton()
}
