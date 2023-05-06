//
//  Color+Extension.swift
//  GymCare
//
//  Created by Truong Nguyen Huu on 26/02/2023.
//

import UIKit

extension UIColor {
    static let main_color = UIColor.color(named: "main_color")
    static let color_FFACCB = UIColor.color(named: "color_EE73A0")
    static let color_46C0FF = UIColor.color(named: "color_00A7FF")
    static let successColor = UIColor.color(named: "success_color")
    static let infoColor = UIColor.color(named: "info_color")
    static let lightGrayColor = UIColor.color(named: "light_gray_color")

    private static func color(named: String) -> UIColor {
        return UIColor(named: named) ?? UIColor.black
    }
}
