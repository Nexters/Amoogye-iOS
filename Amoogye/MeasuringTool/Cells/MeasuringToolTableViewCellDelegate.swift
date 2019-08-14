//
//  MeasuringToolTableViewCellDelegate.swift
//  Amoogye
//
//  Created by JunHui Kim on 15/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import Foundation

protocol MeasuringToolTableViewCellDelegate: class {
    func didOnoffButton(_ tag: Int, isOn: Bool)
}
