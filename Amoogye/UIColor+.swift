//
//  UIColor+.swift
//  Amoogye
//
//  Created by JunHui Kim on 12/08/2019.
//  Copyright © 2019 KookKook. All rights reserved.
//

import UIKit

extension UIColor {

    @nonobjc class var amIceBlue: UIColor {
        return UIColor(red: 241.0 / 255.0, green: 245.0 / 255.0, blue: 247.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var amOrangeyRed: UIColor {
        return UIColor(red: 1.0, green: 79.0 / 255.0, blue: 52.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var amWhite: UIColor {
        return UIColor(white: 1.0, alpha: 1.0)
    }

    @nonobjc class var amDarkBlueGrey: UIColor {
        return UIColor(red: 19.0 / 255.0, green: 28.0 / 255.0, blue: 50.0 / 255.0, alpha: 1.0)
    }

    @nonobjc class var amLightBlueGrey: UIColor {
        return UIColor(red: 188.0 / 255.0, green: 205.0 / 255.0, blue: 214.0 / 255.0, alpha: 1.0)
    }

    static func amDarkBuleGrayWithOpacity(opacity: Double) -> UIColor {
        return UIColor(red: 19.0 / 255.0, green: 28.0 / 255.0, blue: 50.0 / 255.0, alpha: CGFloat(opacity))
    }
}
